import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthModule } from './auth/auth.module';
import { UserModule } from './user/user.module';
import { BillModule } from './bill/bill.module';
import { OrderModule } from './bill/order/order.module';
import { CartModule } from './cart/cart.module';
import { ProductModule } from './product/product.module';
import { UserModule } from './user/user.module';

@Module({
  imports: [AuthModule, UserModule, ProductModule, CartModule, OrderModule, BillModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
