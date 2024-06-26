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
} from '@nestjs/common';
import { CartService } from './cart.service';
import { JwtAuthGuard } from 'src/common/guards/jwt-auth.guard';

@Controller('api/v1/cart')
@UseGuards(JwtAuthGuard)
export class CartController {
  constructor(private cartService: CartService) {}

  @Get('get')
  async getCart(@Request() req) {
    return this.cartService.getCart(req.user.userId);
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

  @Delete('clear')
  async clearCart(@Request() req) {
    await this.cartService.clearCart(req.user.userId);
    return { message: 'Cart cleared successfully' };
  }
}
