import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Order } from './entities/order.entity';
import { OrderItem } from './order-item/entities/order-item.entity';
import { CartService } from '../cart/cart.service';
import { Cart } from '../cart/entities/cart.entity';
import { CartItem } from '../cart/cart-item/entities/cart-item.entity';

@Injectable()
export class OrderService {
  constructor(
    @InjectRepository(Order) private orderRepo: Repository<Order>,
    @InjectRepository(OrderItem) private orderItemRepo: Repository<OrderItem>,
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
      const orderItem: OrderItem = await this.orderItemRepo.save({
        id_order: order.id_order,
        id_product: cartItem.id_product,
        quantity: cartItem.quantity,
        //price: cartItem.product.price,
      });
      orderItems.push(orderItem);
    }

    // Lưu các mục đơn hàng vào cơ sở dữ liệu
    await this.orderItemRepo.save(orderItems);

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
}
