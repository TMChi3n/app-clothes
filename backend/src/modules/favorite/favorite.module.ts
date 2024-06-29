import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Favorite } from './entities/favorite.entity';
import { FavoriteService } from './favorite.service';
import { FavoriteController } from './favorite.controller';
import { UserModule } from 'src/modules/user/user.module';
import { ProductModule } from 'src/modules/product/product.module';

@Module({
  imports: [TypeOrmModule.forFeature([Favorite]), UserModule, ProductModule],
  providers: [FavoriteService],
  controllers: [FavoriteController],
})
export class FavoriteModule {}
