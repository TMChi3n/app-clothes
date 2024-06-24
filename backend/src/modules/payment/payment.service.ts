import { Injectable } from '@nestjs/common';
import { Payment } from './etities/payment.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Order } from '../order/entities/order.entity';

@Injectable()
export class PaymentService {
  constructor(
    @InjectRepository(Payment) private paymentRepo: Repository<Payment>,
    @InjectRepository(Order) private orderRepo: Repository<Order>,
  ) {}

  // Chức năng cập nhật trạng thái thanh toán và ngày hoàn thành (nếu có)
  async updatePaymentStatus(orderId: number, status: string): Promise<Payment | undefined> {
    try {
      // Tìm thanh toán dựa trên orderId
      const payment = await this.paymentRepo.findOne({ where: { id_order: orderId } });

      if (!payment) {
        throw new Error(`Payment with orderId ${orderId} not found`);
      }

      // Cập nhật trạng thái thanh toán
      payment.status = status;

      // Nếu trạng thái là 'completed', cập nhật ngày hoàn thành
      if (status === 'completed' && !payment.payment_date) {
        payment.payment_date = new Date();
      }

      // Lưu thay đổi vào cơ sở dữ liệu
      await this.paymentRepo.save(payment);

      return payment;
    } catch (error) {
      throw new Error(`Error updating payment status: ${error.message}`);
    }
  }
}
