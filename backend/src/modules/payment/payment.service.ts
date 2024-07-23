import { Injectable } from '@nestjs/common';
import { Payment } from './entities/payment.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Order } from '../order/entities/order.entity';
import PayOS from '@payos/node';


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
        '1ae3067c-031c-4bb7-87fb-064308ea0718',
        'f6b455f9-4c3e-41bd-8233-a1d58957e133',
        'cd7436464046c57625523d95936460b8860e2609efcdb91c43d6dad2c9dd33a6'
      );
    } catch (error) {
      throw new Error(`Error initializing PayOS: ${error.message}`);
    }
  }

// Tạo liên kết thanh toán với PayOS
async createPaymentLink(requestData: any) {
  try {
    // Log incoming requestData để debug
    console.log('Incoming requestData:', requestData);

    // Kiểm tra xem order có tồn tại không
    const order = await this.orderRepository.findOne({
      where: { id_order: requestData.id_order },
    });
    if (!order) {
      throw new Error(`Order with id ${requestData.id_order} not found`);
    }

    // Kiểm tra xem payment có tồn tại không
    const payment = await this.paymentRepository.findOne({
      where: { id_order: requestData.id_order },
    });
    if (!payment) {
      throw new Error(`Payment information for order ${requestData.id_order} not found`);
    }

    // Log thông tin payment để debug
    console.log('Payment information:', payment);

    // Chuyển đổi total_amount thành số và gán vào requestData.amount
    requestData.amount = +payment.total_amount;
    if (isNaN(requestData.amount)) {
      throw new Error(`Invalid amount for payment of order ${requestData.id_order}`);
    }

    // Tạo requestData mới chỉ với các thông tin bắt buộc
    const payOSRequestData = {
      orderCode: requestData.id_order,
      amount: requestData.amount,
      description: requestData.description || `Payment for order #${requestData.id_order}`,
      returnUrl: requestData.returnUrl || "https://your-domain.com/payment/success",
      cancelUrl: requestData.cancelUrl || "https://your-domain.com/payment/cancel",
    };

    // Log requestData và payOSRequestData để debug
    console.log('Updated requestData:', requestData);
    console.log('Generated payOSRequestData:', payOSRequestData);

    // Gọi hàm tạo liên kết thanh toán từ PayOS
    const paymentLinkData = await this.payos.createPaymentLink(payOSRequestData);

    // Cập nhật thông tin thanh toán trong cơ sở dữ liệu
    payment.payment_link = paymentLinkData.paymentLinkId;
    await this.paymentRepository.save(payment);

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
      try {
      // Tìm kiếm và cập nhật thông tin thanh toán trong cơ sở dữ liệu
      const payment = await this.paymentRepository.findOne({ where: { id_order } });
  
      if (payment) {
        payment.status = 'completed';
        payment.payment_date = new Date();
        await this.paymentRepository.save(payment);
      }
    }catch (error) {
      throw new Error(`Error updating payment status: ${error.message}`);
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

  // Cập nhật trạng thái thanh toán và ngày hoàn thành (nếu có)
  async updatePaymentStatus(orderId: number, status: string, paymentDate?: Date): Promise<Payment | undefined> {
    try {
      // Tìm thanh toán dựa trên orderId
      const payment = await this.paymentRepository.findOne({ where: { id_order: orderId } });

      if (!payment) {
        throw new Error(`Payment with orderId ${orderId} not found`);
      }

      // Cập nhật trạng thái thanh toán
      payment.status = status;

      // Nếu trạng thái là 'completed', cập nhật ngày hoàn thành
      if (status === 'COMPLETED' && paymentDate) {
        payment.payment_date = paymentDate;
      }

      // Lưu thay đổi vào cơ sở dữ liệu
      await this.paymentRepository.save(payment);

      return payment;
    } catch (error) {
      throw new Error(`Error updating payment status: ${error.message}`);
    }
  }

  // Lấy thông tin thanh toán từ cơ sở dữ liệu dựa trên ID
  async findPaymentById(paymentId: number): Promise<Payment | undefined> {
    try {
      const payment = await this.paymentRepository.findOne({where: { id_payment: paymentId }});
      return payment;
    } catch (error) {
      throw new Error(`Error finding payment by id: ${error.message}`);
    }
  }

  // Lấy danh sách tất cả các thanh toán từ cơ sở dữ liệu
  async findAllPayments(): Promise<Payment[]> {
    try {
      const payments = await this.paymentRepository.find();
      return payments;
    } catch (error) {
      throw new Error(`Error finding all payments: ${error.message}`);
    }
  }

  // Xóa liên kết thanh toán
  async deletePaymentLink(orderId: number) {
    try {
      const payment = await this.paymentRepository.findOne({ where: { id_order: orderId } });
      if (!payment) {
        throw new Error(`Payment with orderId ${orderId} not found`);
      }
  
      await this.paymentRepository.remove(payment);
      return { success: true, message: `Payment link for order ${orderId} has been deleted` };
    } catch (error) {
      throw new Error(`Error deleting payment link: ${error.message}`);
    }
  }
}
