// app.module.ts
import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Product } from './modules/product/entities/product.entity';
import { ProductModule } from './modules/product/product.module';
import { User } from './modules/user/entities/user.entity';
import { AuthModule } from './modules/auth/auth.module';
import { Cart } from './modules/cart/entities/cart.entity';
import { CartItem } from './modules/cart/cart-item/entities/cart-item.entity';
import { CartModule } from './modules/cart/cart.module';
import { Order } from './modules/order/entities/order.entity';
import { OrderItem } from './modules/order/order-item/entities/order-item.entity';
import { Payment } from './modules/payment/etities/payment.entity';
import { OrderModule } from './modules/order/order.module';

@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true }),
    TypeOrmModule.forRoot({
      type: 'mysql',
      host: process.env.DB_HOST,
      port: parseInt(process.env.DB_PORT, 10),
      username: process.env.DB_USERNAME,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_DATABASE,
      synchronize: true,
      entities: [Product, User, Cart, CartItem, Order, OrderItem, Payment],
    }),
    ProductModule,
    AuthModule,
    CartModule,
    OrderModule,
  ],
})
export class AppModule {}
