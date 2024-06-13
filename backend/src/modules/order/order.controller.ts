import { Controller, Post, Body, UseGuards, Get, Param, Patch, Request, Delete } from '@nestjs/common';
import { OrderService } from './order.service';
import { JwtAuthGuard } from 'src/common/guards/jwt-auth.guard';

@Controller('api/v1/order')
@UseGuards(JwtAuthGuard)
export class OrderController {
  constructor(private orderService: OrderService) {}

  @Post('create')
  async createOrder(@Body() body) {
    const { userId, address, phoneNumber } = body;
    console.log('Creating order for user:', userId);
    return this.orderService.createOrderFromCart(userId, address, phoneNumber);
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
  async updateOrderStatus(@Param('id') id: number, @Body('status') status: string) {
    return this.orderService.updateOrderStatus(id, status);
  }

  @Delete(':id')
  async deleteOrder(@Param('id') id:number){
    return this.orderService.deleteOrder(id);
  }
}
 