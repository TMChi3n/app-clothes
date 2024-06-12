import { Column, Entity, JoinColumn, ManyToOne, PrimaryGeneratedColumn } from 'typeorm';
import { Order } from 'src/modules/order/entities/order.entity'
import { Product } from 'src/modules/product/entities/product.entity';

@Entity()
export class OrderItem {
  @PrimaryGeneratedColumn()
  id_order_detail: number;

  @Column()
  id_order: number;

  @Column()
  id_product: number;

  @Column()
  quantity: number;

  @Column({nullable: true})
  price: number;

  @ManyToOne(() => Order, (order) => order.orderItems)
  @JoinColumn({ name: 'id_order' })
  order: Order;

  @ManyToOne(() => Product, (product) => product.orderItems)
  @JoinColumn({ name: 'id_product' })
  product: Product;
}
