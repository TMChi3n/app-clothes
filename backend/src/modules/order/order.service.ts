import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Order } from './entities/order.entity';
import { OrderItem } from './order-item/entities/order-item.entity';
import { CartService } from '../cart/cart.service';
import { Cart } from '../cart/entities/cart.entity';
import { ProductService } from '../product/product.service';
import { Payment } from '../payment/entities/payment.entity';
import { User } from '../user/entities/user.entity';
import { UserService } from '../user/user.service';

@Injectable()
export class OrderService {
  constructor(
    @InjectRepository(Order) private orderRepo: Repository<Order>,
    @InjectRepository(OrderItem) private orderItemRepo: Repository<OrderItem>,
    @InjectRepository(Payment) private paymentRepo: Repository<Payment>,
    private productService: ProductService,
    private cartService: CartService,
    private userService: UserService,
  ) {}

  async createOrderFromCart(userId: number, paymentMethod: 'cash' | 'banking') {
    // Lấy giỏ hàng từ dịch vụ giỏ hàng
    const cart: Cart = await this.cartService.getCart(userId);
    console.log('Cart retrieved:', cart);

    // Kiểm tra nếu giỏ hàng rỗng
    if (!cart || !cart.cartItems || cart.cartItems.length === 0) {
      throw new Error('Cart is empty');
    }

    // Lấy dữ liệu từ user
    const user: User = await this.userService.findById(userId);

    // Kiểm tra nếu dữ liệu trống
    if (!user || !user.address || !user.phone_number) {
      throw new Error(
        'User data is incomplete (missing address or phone number)',
      );
    }

    console.log('Creating order with userId:', userId);
    // Tạo đơn hàng mới
    const order: Order = await this.orderRepo.save({
      id_user: userId,
      status: 'pending',
      order_date: new Date(),
    });

    // Tạo các mục đơn hàng từ các mục trong giỏ hàng
    const orderItems: OrderItem[] = [];
    for (const cartItem of cart.cartItems) {
      // Lấy thông tin sản phẩm từ bảng product
      const product = await this.productService.findProductById(
        cartItem.id_product,
      );
      if (!product) {
        throw new Error(`Product with id ${cartItem.id_product} not found`);
      }
      const orderItem: OrderItem = await this.orderItemRepo.save({
        id_order: order.id_order,
        id_product: cartItem.id_product,
        quantity: cartItem.quantity,
        price: product.price,
        address: user.address,
        phone_number: user.phone_number,
      });
      orderItems.push(orderItem);
    }

    // Lưu các mục đơn hàng vào cơ sở dữ liệu
    await this.orderItemRepo.save(orderItems);

    // Tính tổng số tiền của đơn hàng
    const totalAmount = orderItems.reduce(
      (total, item) => total + item.quantity * item.price,
      0,
    );

    // Tạo và lưu thanh toán cho đơn hàng
    const payment: Payment = await this.paymentRepo.save({
      id_order: order.id_order,
      total_amount: totalAmount,
      payment_method: paymentMethod,
    });

    console.log(payment);

    // Xóa giỏ hàng sau khi đã tạo đơn hàng thành công
    await this.cartService.clearCart(userId);

    return order;
  }
  async getOrder(orderId: number) {
    return this.orderRepo.findOne({ where: { id_order: orderId } });
  }

  async getOrdersByUser(userId: number) {
    return this.orderRepo.find({ where: { id_user: userId } });
  }

  async updateOrderStatus(orderId: number, status: string) {
    const order = await this.orderRepo.findOne({
      where: { id_order: orderId },
    });
    if (!order) {
      throw new Error('Order not found');
    }
    order.status = status;
    if (status === 'completed' && !order.completed_date) {
      order.completed_date = new Date();

      // Tìm thanh toán dựa trên orderId
      const payment = await this.paymentRepo.findOne({
        where: { id_order: orderId },
      });
      if (
        payment &&
        payment.payment_method === 'cash' &&
        !payment.payment_date
      ) {
        payment.payment_date = new Date();
        await this.paymentRepo.save(payment);
      }
    }
    return this.orderRepo.save(order);
  }

  async deleteOrder(orderId: number) {
    const order = await this.orderRepo.findOne({
      where: { id_order: orderId },
    });
    if (order) {
      await this.orderItemRepo.delete({ id_order: orderId });
      return this.orderRepo.delete({ id_order: orderId });
    }
    throw new Error('Order not found');
  }

  async calculateTotalAmount(orderId: number): Promise<number> {
    const order = await this.orderRepo.findOne({
      where: { id_order: orderId },
      relations: ['orderItems'],
    });

    if (!order) {
      throw new Error('Order not found');
    }

    // Tính tổng số tiền từ các mục trong đơn hàng
    let totalAmount = 0;
    for (const orderItem of order.orderItems) {
      totalAmount += orderItem.quantity * orderItem.price;
    }

    return totalAmount;
  }

  async getAllOrders(
    startDate?: Date,
    endDate?: Date,
    status?: string,
  ): Promise<Order[]> {
    const queryBuilder = this.orderRepo
      .createQueryBuilder('order')
      .leftJoinAndSelect('order.orderItems', 'orderItems');

    if (startDate) {
      queryBuilder.andWhere('order.order_date >= :startDate', { startDate });
    }

    if (endDate) {
      queryBuilder.andWhere('order.order_date <= :endDate', { endDate });
    }

    if (status) {
      queryBuilder.andWhere('order.status = :status', { status });
    }

    return queryBuilder.getMany();
  }
}