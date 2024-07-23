import {
  Controller,
  Get,
  Post,
  Body,
  UseGuards,
  Request,
  Delete,
  Param,
  Patch,
  ParseIntPipe,
} from '@nestjs/common';
import { CartService } from './cart.service';
import { JwtAuthGuard } from 'src/common/guards/jwt-auth.guard';

@Controller('api/v1/cart')
@UseGuards(JwtAuthGuard)
export class CartController {
  constructor(private cartService: CartService) {}

  @Get('get/:userId')
  async getCart(@Param('userId') userId: number) {
    return this.cartService.getCart(userId);
  }

  @Post('add')
  async addToCart(@Body() body) {
    const { userId, productId, quantity } = body;
    return this.cartService.addToCart(userId, productId, quantity);
  }

  @UseGuards(JwtAuthGuard)
  @Delete('remove/:id')
  async removeFromCart(@Param('id') id: string) {
    await this.cartService.removeFromCart(+id);
    return 'Remove successfully';
  }

  @UseGuards(JwtAuthGuard)
  @Patch('increase/:id')
  async increaseQuantity(@Param('id') id: string) {
    const updatedCartItem = await this.cartService.increaseQuantity(+id);
    return { cartItem: updatedCartItem };
  }

  @UseGuards(JwtAuthGuard)
  @Patch('decrease/:id')
  async decreaseQuantity(@Param('id') id: string) {
    const updatedCartItem = await this.cartService.decreaseQuantity(+id);
    return { cartItem: updatedCartItem };
  }

  @Delete('clear/:userId')
  async clearCart(
    @Param('userId', ParseIntPipe) userId: number,
  ): Promise<void> {
    await this.cartService.clearCart(userId);
  }
}
