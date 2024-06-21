import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Favorite } from './entities/favorite.entity';
import { User } from 'src/modules/user/entities/user.entity';
import { Product } from 'src/modules/product/entities/product.entity';

@Injectable()
export class FavoriteService {
  constructor(
    @InjectRepository(Favorite)
    private favoriteRepository: Repository<Favorite>,
  ) {}

  async addFavorite(user: User, product: Product): Promise<Favorite> {
    const newFavorite = new Favorite();
    newFavorite.user = user;
    newFavorite.product = product;
    return this.favoriteRepository.save(newFavorite);
  }

  async removeFavorite(user: User, product: Product): Promise<void> {
    await this.favoriteRepository.delete({ user, product });
  }

  async getFavoritesByUser(user: User): Promise<Product[]> {
    const favorites = await this.favoriteRepository.find({
      where: { user },
      relations: ['product'],
    });
    return favorites.map(favorite => favorite.product);
  }
}
