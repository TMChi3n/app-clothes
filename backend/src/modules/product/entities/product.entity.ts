import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm';

@Entity({ name: 'product' }) // Sử dụng tên bảng 'product'
export class Product {
  @PrimaryGeneratedColumn({ name: 'id_product' }) // Sử dụng tên cột 'id_product'
  id_product: number;

  @Column({ length: 100 })
  name: string;

  @Column({ nullable: true, type: 'text' }) // Đặt nullable: true cho các cột không bắt buộc
  person: string;

  @Column({ nullable: true, type: 'text' }) // Đặt nullable: true cho các cột không bắt buộc
  material: string;

  @Column({ nullable: true, type: 'text' }) // Đặt nullable: true cho các cột không bắt buộc
  overview: string;

  @Column({ type: 'decimal', precision: 20, scale: 2 })
  price: number;

  @Column({ type: 'longblob' }) // Sử dụng type 'longblob'
  img_url: Buffer;

  @Column({ length: 255 }) // Sử dụng length cho cột type 'nvarchar'
  type: string;
}
