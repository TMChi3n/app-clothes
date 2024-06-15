import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Order } from './entities/order.entity';
import { OrderItem } from './order-item/entities/order-item.entity';
import { CartService } from '../cart/cart.service';
import { Cart } from '../cart/entities/cart.entity';
import { CartItem } from '../cart/cart-item/entities/cart-item.entity';
import { ProductService } from '../product/product.service';
import { Payment } from '../payment/etities/payment.entity';

@Injectable()
export class OrderService {
  constructor(
    @InjectRepository(Order) private orderRepo: Repository<Order>,
    @InjectRepository(OrderItem) private orderItemRepo: Repository<OrderItem>,
    @InjectRepository(Payment) private paymentRepo: Repository<Payment>,
    private productService: ProductService,
    private cartService: CartService,
  ) {}

  async createOrderFromCart(userId: number, address: string, phoneNumber: string) {
    // Lấy giỏ hàng từ dịch vụ giỏ hàng
    const cart: Cart = await this.cartService.getCart(userId);
    console.log('Cart retrieved:', cart);

    // Kiểm tra nếu giỏ hàng rỗng
    if (!cart || !cart.cartItems || cart.cartItems.length === 0) {
      throw new Error('Cart is empty');
    }

    console.log('Creating order with userId:', userId);
    // Tạo đơn hàng mới
    const order: Order = await this.orderRepo.save({
      id_user: userId,
      status: 'pending',
      order_date: new Date(),
      address,
      phone_number: phoneNumber,
    });

    // Tạo các mục đơn hàng từ các mục trong giỏ hàng
    const orderItems: OrderItem[] = [];
    for (const cartItem of cart.cartItems) {
      // Lấy thông tin sản phẩm từ bảng product
      const product = await this.productService.findProductById(cartItem.id_product);
      if (!product) {
        throw new Error(`Product with id ${cartItem.id_product} not found`);
      }
      const orderItem: OrderItem = await this.orderItemRepo.save({
        id_order: order.id_order,
        id_product: cartItem.id_product,
        quantity: cartItem.quantity,
        price: product.price,
      });
      orderItems.push(orderItem);
    }

    // Lưu các mục đơn hàng vào cơ sở dữ liệu
    await this.orderItemRepo.save(orderItems);

     // Tính tổng số tiền của đơn hàng
     const totalAmount = orderItems.reduce((total, item) => total + item.quantity * item.price, 0);

     // Tạo và lưu thanh toán cho đơn hàng
     const payment: Payment = await this.paymentRepo.save({
       id_order: order.id_order,
       total_amount: totalAmount,
       payment_method: 'banking', // Giả sử bạn đang sử dụng phương thức thanh toán là banking
       payment_date: new Date(),
     }); 

    // Xóa giỏ hàng sau khi đã tạo đơn hàng thành công
    await this.cartService.clearCart(userId);

    return order;
  }
  async getOrder(orderId: number) {
    return this.orderRepo.findOne({ where: {id_order: orderId}});
  }

  async getOrdersByUser(userId: number) {
    return this.orderRepo.find({ where: { id_user: userId } });
  }

  async updateOrderStatus(orderId: number, status: string) {
    const order = await this.orderRepo.findOne({ where: { id_order: orderId } });
    if (!order) {
      throw new Error('Order not found');
    }
    order.status = status;
    return this.orderRepo.save(order);
  }

  async deleteOrder(orderId: number) {
    const order = await this.orderRepo.findOne({ where: { id_order: orderId } });
    if (order) {
      await this.orderItemRepo.delete({ id_order: orderId }); 
      return this.orderRepo.delete({ id_order: orderId });
    }
    throw new Error('Order not found');
  }

  async calculateTotalAmount(orderId: number): Promise<number> {
    // Tìm đơn hàng dựa trên orderId
    const order = await this.orderRepo.findOne({
      where: { id_order: orderId },
      relations: ['orderItems'], // Include relation to orderItems
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
}
