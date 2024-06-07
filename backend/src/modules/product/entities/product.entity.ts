import { CartItem } from 'src/modules/cart/cart-item/entities/cart-item.entity';
import { Entity, Column, PrimaryGeneratedColumn, OneToMany } from 'typeorm';

@Entity({ name: 'product' }) // Sử dụng tên bảng 'product'
export class Product {
  @PrimaryGeneratedColumn({ name: 'id_product' }) // Sử dụng tên cột 'id_product'
  id_product: number;

  @Column({ length: 100 })
  name: string;

  @Column('text')
  descriptions: string;

  @Column({ type: 'decimal', precision: 20, scale: 2 })
  price: number;

  @Column({ type: 'longblob' }) // Sử dụng type 'longblob'
  img_url: Buffer;

  @Column({ length: 255 }) // Sử dụng length cho cột type 'nvarchar'
  type: string;

  @Column('text')
  person: string;

  @OneToMany(() => CartItem, (cartItem) => cartItem.product)
  cartItems: CartItem[];
}
