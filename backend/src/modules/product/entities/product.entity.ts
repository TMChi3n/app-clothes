import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm';

@Entity()
export class Product {
  @PrimaryGeneratedColumn()
  id_product: number;

  @Column({ length: 100 })
  name: string;

  @Column('text')
  descriptions: string;

  @Column('decimal', { precision: 20, scale: 2 })
  price: number;

  @Column('longblob')
  img_url: Buffer;

  @Column('int')
  stock_quantity: number;

  @Column({ type: 'nvarchar', length: 255 })
  brand: string;
}
