import { Controller, Post, Body, Param, Get, Patch, Delete, NotFoundException } from '@nestjs/common';
import { Payment } from './etities/payment.entity';
import { PaymentService } from './payment.service';

@Controller('api/v1/payment')
export class PaymentController {
  constructor(private readonly paymentService: PaymentService) {}

  @Post('create-link')
  async createPaymentLink(@Body() requestData: any) {
    try {
      const paymentLinkData = await this.paymentService.createPaymentLink(requestData);
      return { success: true, data: paymentLinkData };
    } catch (error) {
      return { success: false, error: error.message };
    }
  }

  @Get(':id')
  async getPaymentLinkInfo(@Param('id') id: number) {
    try {
      const paymentLinkInfo = await this.paymentService.getPaymentLinkInformation(id);
      return { success: true, data: paymentLinkInfo };
    } catch (error) {
      return { success: false, error: error.message };
    }
  }

  @Delete('cancel/:id_order')
  async cancelPaymentLink(@Param('id_order') id_order: number, @Body('reason') reason?: string) {
    try {
      const cancelledPaymentInfo = await this.paymentService.cancelPaymentLink(id_order, reason);
      return { success: true, data: cancelledPaymentInfo };
    } catch (error) {
      return { success: false, error: error.message };
    }
  }

  @Get('/get')
  findAllPayments(): Promise<Payment[]> {
     return this.paymentService.findAllPayments();
  }
  
  @Post('webhook')
  async handleWebhook(@Body() body: any) {
    try {
      // Xác minh webhook từ PayOS
      const webhookData = this.paymentService.verifyWebhook(body);

      // Xử lý logic dựa trên dữ liệu webhook nhận được
      await this.paymentService.handleWebhook(webhookData);

      return { success: true };
    } catch (error) {
      return { success: false, error: error.message };
    }
  }

  @Patch(':orderId')
  async updatePaymentStatus(
    @Param('orderId') orderId: number,
    @Body('status') status: string,
  ): Promise<Payment | undefined> {
    try {
      const updatedPayment = await this.paymentService.updatePaymentStatus(orderId, status);
      if (!updatedPayment) {
        throw new NotFoundException(`Payment with orderId ${orderId} not found`);
      }
      return updatedPayment;
    } catch (error) {
      throw new NotFoundException(`Error updating payment status: ${error.message}`);
    }
  }
}
