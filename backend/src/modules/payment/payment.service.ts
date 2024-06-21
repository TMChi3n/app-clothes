import { Injectable } from '@nestjs/common';
import PayOS from '@payos/node'; 
import { Payment } from './etities/payment.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Order } from '../order/entities/order.entity';

@Injectable()
export class PaymentService {
  private payos: PayOS;

  constructor(
    @InjectRepository(Payment) private paymentRepository: Repository<Payment>,
    @InjectRepository(Order) private orderRepository: Repository<Order>,
  ) {
    // Khởi tạo PayOS object với các thông tin cần thiết
    try {
      this.payos = new PayOS(
        'YOUR_PAYOS_CLIENT_ID', 
        'YOUR_PAYOS_API_KEY', 
        'YOUR_PAYOS_CHECKSUM_KEY'
      );
    } catch (error) {
      throw new Error(`Error initializing PayOS: ${error.message}`);
    }
  }

  // Tạo liên kết thanh toán với PayOS
  async createPaymentLink(requestData: any) {
    try {
      // Kiểm tra xem order có tồn tại không
      const order = await this.orderRepository.findOne({ where: { id_order: requestData.id_order } });
      if (!order) {
        throw new Error(`Order with id ${requestData.id_order} not found`);
      }
      const paymentLinkData = await this.payos.createPaymentLink(requestData);
      return paymentLinkData;
    } catch (error) {
      throw new Error(`Error creating payment link: ${error.message}`);
    }
  }

  // Lấy thông tin liên kết thanh toán từ PayOS
  async getPaymentLinkInformation(id_payment: string | number) {
    try {
      const paymentLinkInfo = await this.payos.getPaymentLinkInformation(id_payment);
      return paymentLinkInfo;
    } catch (error) {
      throw new Error(`Error getting payment link information: ${error.message}`);
    }
  }  

  // Hủy bỏ liên kết thanh toán trên PayOS
  async cancelPaymentLink(id_order: number, cancellationReason?: string) {
    try {
      const cancelledPaymentLinkInfo = await this.payos.cancelPaymentLink(id_order, cancellationReason);
      return cancelledPaymentLinkInfo;
    } catch (error) {
      throw new Error(`Error cancelling payment link: ${error.message}`);
    }
  }

  async savePayment(paymentData: Payment) {
    return this.paymentRepository.save(paymentData);
  }

  async findPaymentById(paymentId: number) {
    return this.paymentRepository.findOne({where: {id_payment: paymentId}});
  }

  async findAllPayments(): Promise<Payment[]> {
    return this.paymentRepository.find();
  }

  // Xác minh tính hợp lệ của webhook từ PayOS
  async verifyWebhook(body: any) {
    try {
      return this.payos.verifyPaymentWebhookData(body);
    } catch (error) {
      throw new Error(`Error verifying webhook: ${error.message}`);
    }
  }

  async handleWebhook(webhookData: any) {
    const { id_order, status } = webhookData;
  
    if (status === 'SUCCESS') {
      // Tìm kiếm và cập nhật thông tin thanh toán trong cơ sở dữ liệu
      const payment = await this.paymentRepository.findOne({ where: { id_order } });
  
      if (payment) {
        payment.status = 'completed';
        await this.paymentRepository.save(payment);
      }
    }
}

  async confirmWebhook(webhookUrl: string) {
    try {
      await this.payos.confirmWebhook(webhookUrl);
      return { success: true };
    } catch (error) {
      throw new Error(`Error confirming webhook: ${error.message}`);
    }
  }

  // Chức năng cập nhật trạng thái thanh toán và ngày hoàn thành (nếu có)
  async updatePaymentStatus(orderId: number, status: string): Promise<Payment | undefined> {
    try {
      // Tìm thanh toán dựa trên orderId
      const payment = await this.paymentRepository.findOne({ where: { id_order: orderId } });

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
      await this.paymentRepository.save(payment);

      return payment;
    } catch (error) {
      throw new Error(`Error updating payment status: ${error.message}`);
    }
  }


}
