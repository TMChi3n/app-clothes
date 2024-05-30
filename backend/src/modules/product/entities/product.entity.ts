import { Column, PrimaryGeneratedColumn } from 'typeorm';

export class Product {
  @PrimaryGeneratedColumn()
  id_product: string;
  @Column()
  name: string;
  @Column()
  descriptions: string;
  @Column()
  price: number;
  @Column()
  img_url: string;
  @Column()
  stock_quantity: number;
  @Column()
  brand: string;
}
