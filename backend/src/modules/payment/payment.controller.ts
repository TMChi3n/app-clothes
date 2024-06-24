import { Controller, Post, Body, Param, Get, Patch, Delete, NotFoundException } from '@nestjs/common';
import { Payment } from './etities/payment.entity';
import { PaymentService } from './payment.service';

@Controller('api/v1/payment')
export class PaymentController {
  constructor(private readonly paymentService: PaymentService) {}
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
