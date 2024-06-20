import { CartItem } from 'src/modules/cart/cart-item/entities/cart-item.entity';
import { Entity, Column, PrimaryGeneratedColumn, OneToMany } from 'typeorm';
import { OrderItem } from 'src/modules/order/order-item/entities/order-item.entity';
@Entity()
export class Product {
  @PrimaryGeneratedColumn()
  id_product: number;

  @Column({ type: 'nvarchar', length: 255 })
  name: string;

  @Column('text')
  material: string;

  @Column('text')
  overview: string;

  @Column('decimal', { precision: 20, scale: 2 })
  price: number;

  @Column('longblob')
  img_url: string;

  @Column({ type: 'nvarchar', length: 255 })
  type: string;

  @Column({ type: 'nvarchar', length: 255 })
  person: string;

  @OneToMany(() => CartItem, (cartItem) => cartItem.product)
  cartItems: CartItem[];

  @OneToMany(() => OrderItem, (orderItem) => orderItem.product)
  orderItems: OrderItem[];
}
