import { Controller, Post, Delete, UseGuards, Get, Req, Param } from '@nestjs/common';
import { FavoriteService } from './favorite.service';
import { User } from 'src/modules/user/entities/user.entity';
import { Product } from 'src/modules/product/entities/product.entity';
import { JwtAuthGuard } from 'src/common/guards/jwt-auth.guard';
import { ProductService } from '../product/product.service';

@Controller('api/v1/favorite')
@UseGuards(JwtAuthGuard)
export class FavoriteController {
  constructor(
    private readonly favoriteService: FavoriteService,
    private readonly productService: ProductService,
) {}

  @Post(':productId/add')
  async addFavorite(
    @Req() req,
    @Param('productId') productId: number,
  ): Promise<void> {
    const user: User = req.user;
    const product: Product = await this.productService.findProductById(productId);
    await this.favoriteService.addFavorite(user, product);
  }

  @Delete(':productId/remove')
  async removeFavorite(
    @Req() req,
    @Param('productId') productId: number,
  ): Promise<void> {
    const user: User = req.user;
    const product: Product = await this.productService.findProductById(productId);
    await this.favoriteService.removeFavorite(user, product);
  }

  @Get('/user')
  async getFavoritesByUser(@Req() req): Promise<Product[]> {
    const user: User = req.user;
    return this.favoriteService.getFavoritesByUser(user);
  }
}
