import { Controller, Post, Body, Param, Get, Patch, Delete, NotFoundException, BadRequestException } from '@nestjs/common';
import { Payment } from './etities/payment.entity';
import { PaymentService } from './payment.service';

@Controller('api/v1/payment')
export class PaymentController {
  constructor(private readonly paymentService: PaymentService) {}

  @Post('create-payment-link')
  async createPaymentLink(@Body() requestData: any): Promise<any> {
    try {
      const paymentLinkData = await this.paymentService.createPaymentLink(requestData);
      return { success: true, data: paymentLinkData };
    } catch (error) {
      throw new BadRequestException(`Error creating payment link: ${error.message}`);
    }
  }

  @Get('payment-link/:id')
  async getPaymentLinkInformation(@Param('id') id_payment: string | number): Promise<any> {
    try {
      const paymentLinkInfo = await this.paymentService.getPaymentLinkInformation(id_payment);
      return { success: true, data: paymentLinkInfo };
    } catch (error) {
      throw new NotFoundException(`Error getting payment link information: ${error.message}`);
    }
  }

  @Patch('cancel-payment-link/:orderId')
  async cancelPaymentLink(
    @Param('orderId') orderId: number,
    @Body('cancellationReason') cancellationReason?: string,
  ): Promise<any> {
    try {
      const cancelledPaymentLinkInfo = await this.paymentService.cancelPaymentLink(orderId, cancellationReason);
      return { success: true, data: cancelledPaymentLinkInfo };
    } catch (error) {
      throw new NotFoundException(`Error cancelling payment link: ${error.message}`);
    }
  }

  @Post('verify-webhook')
  async verifyWebhook(@Body() body: any): Promise<any> {
    try {
      const verified = await this.paymentService.verifyWebhook(body);
      return { success: true, verified };
    } catch (error) {
      throw new BadRequestException(`Error verifying webhook: ${error.message}`);
    }
  }

  @Post('handle-webhook')
  async handleWebhook(@Body() webhookData: any): Promise<any> {
    try {
      await this.paymentService.handleWebhook(webhookData);
      return { success: true };
    } catch (error) {
      throw new BadRequestException(`Error handling webhook: ${error.message}`);
    }
  }

  @Post('confirm-webhook')
  async confirmWebhook(@Body('webhookUrl') webhookUrl: string): Promise<any> {
    try {
      const confirmation = await this.paymentService.confirmWebhook(webhookUrl);
      return { success: true, data: confirmation };
    } catch (error) {
      throw new BadRequestException(`Error confirming webhook: ${error.message}`);
    }
  }

  @Patch(':orderId/update-status')
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

  @Get(':paymentId')
  async findPaymentById(@Param('paymentId') paymentId: number): Promise<Payment | undefined> {
    try {
      const payment = await this.paymentService.findPaymentById(paymentId);
      if (!payment) {
        throw new NotFoundException(`Payment with id ${paymentId} not found`);
      }
      return payment;
    } catch (error) {
      throw new NotFoundException(`Error finding payment by id: ${error.message}`);
    }
  }

  @Get()
  async findAllPayments(): Promise<Payment[]> {
    try {
      const payments = await this.paymentService.findAllPayments();
      return payments;
    } catch (error) {
      throw new NotFoundException(`Error finding all payments: ${error.message}`);
    }
  }
}
