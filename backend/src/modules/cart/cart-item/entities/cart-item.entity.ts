import {
  Column,
  Entity,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { Cart } from '../../entities/cart.entity';
import { Product } from 'src/modules/product/entities/product.entity';

@Entity()
export class CartItem {
  @PrimaryGeneratedColumn()
  id_cart_detail: number;

  @Column()
  id_cart: number;

  @Column()
  id_product: number;

  @Column()
  quantity: number;

  @Column({ default: false })
  isSelected: boolean;

  @ManyToOne(() => Cart, (cart) => cart.cartItems)
  @JoinColumn({ name: 'id_cart' })
  cart: Cart;

  @ManyToOne(() => Product, (product) => product.cartItems)
  @JoinColumn({ name: 'id_product' })
  product: Product;
}
