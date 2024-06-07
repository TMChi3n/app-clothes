import { CartItem } from 'src/modules/cart/cart-item/entities/cart-item.entity';
import { Entity, Column, PrimaryGeneratedColumn, OneToMany } from 'typeorm';

@Entity()
export class Product {
  @PrimaryGeneratedColumn()
  id_product: number;

  @Column({ length: 100 })
  name: string;

  @Column('text')
  material: string;

  @Column('text')
  overview: string;

  @Column('decimal', { precision: 20, scale: 2 })
  price: number;

  @Column('longblob')
  img_url: Buffer;

  @Column({ type: 'nvarchar', length: 255 })
  type: string;

  @Column('text')
  person: string;

  @OneToMany(() => CartItem, (cartItem) => cartItem.product)
  cartItems: CartItem[];
}
