import {
  Controller,
  Post,
  Body,
  UseGuards,
  Get,
  Param,
  Patch,
  Request,
  Delete,
  Query,
} from '@nestjs/common';
import { OrderService } from './order.service';
import { JwtAuthGuard } from 'src/common/guards/jwt-auth.guard';
import { PaymentService } from '../payment/payment.service';
import { RoleGuard } from 'src/common/guards/role-auth.guard';
import { Role } from 'src/common/decorators/role';

@Controller('api/v1/order')
@UseGuards(JwtAuthGuard)
export class OrderController {
  constructor(
    private orderService: OrderService,
    private paymentService: PaymentService,
  ) {}

  @Post('create')
  async createOrder(@Request() req, @Body() body) {
    console.log('Request user:', req.user);
    const userId = req.user?.id_user;
    const { paymentMethod } = body;
    console.log('Creating order for user:', userId, 'with payment method:', paymentMethod,);
    if (!userId) {
      throw new Error('User ID is missing');
    }
    return this.orderService.createOrderFromCart(userId, paymentMethod);
  }

  @Get(':id')
  async getOrder(@Param('id') id: number) {
    return this.orderService.getOrder(id);
  }

  @Get('user/:userId')
  async getOrdersByUser(@Param('userId') userId: number) {
    return this.orderService.getOrdersByUser(userId);
  }

  @Patch(':id/status')
  @UseGuards(JwtAuthGuard, RoleGuard)
  @Role('admin')
  async updateOrderStatus(
    @Param('id') id: number,
    @Body('status') status: string,
  ) {
    const order = await this.orderService.updateOrderStatus(id, status);
    // Nếu trạng thái là 'completed', cập nhật trạng thái thanh toán
    if (status === 'completed') {
      await this.paymentService.updatePaymentStatus(id, status);
    }
    return order;
  }

  @Delete(':id')
  async deleteOrder(@Param('id') id: number) {
    return this.orderService.deleteOrder(id);
  }

  @Get(':id/totalAmount')
  async getOrderTotalAmount(@Param('id') id: number): Promise<number> {
    return this.orderService.calculateTotalAmount(id);
  }

  @Get()
  async getAllOrders(
    @Query('startDate') startDate?: string,
    @Query('endDate') endDate?: string,
    @Query('status') status?: string,
  ) {
    const parsedStartDate = startDate ? new Date(startDate) : undefined;
    const parsedEndDate = endDate ? new Date(endDate) : undefined;
    return this.orderService.getAllOrders(
      parsedStartDate,
      parsedEndDate,
      status,
    );
  }
}
