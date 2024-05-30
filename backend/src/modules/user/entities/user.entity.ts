import { Column, PrimaryGeneratedColumn } from 'typeorm';

export class User {
  @PrimaryGeneratedColumn()
  id_product: number;
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
