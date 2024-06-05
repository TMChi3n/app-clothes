import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm';

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

  @Column({ type: 'varchar', length: 255 })
  type: string;

  @Column('text')
  person: string;
}
