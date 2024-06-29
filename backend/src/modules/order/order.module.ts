import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { OrderService } from './order.service';
import { OrderController } from './order.controller';
import { Order } from './entities/order.entity';
import { OrderItem } from './order-item/entities/order-item.entity';
import { Payment } from '../payment/etities/payment.entity';
import { CartModule } from '../cart/cart.module';
import { ProductModule } from '../product/product.module';
import { UserModule } from '../user/user.module';
import { User } from '../user/entities/user.entity';
import { PaymentModule } from '../payment/payment.module';
@Module({
  imports: [TypeOrmModule.forFeature([Order, OrderItem, Payment, User]), CartModule, ProductModule, UserModule, PaymentModule],
  controllers: [OrderController],
  providers: [OrderService],
})
export class OrderModule {}