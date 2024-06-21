import { Column, Entity, JoinColumn, ManyToOne, PrimaryGeneratedColumn } from 'typeorm';
import { Order } from 'src/modules/order/entities/order.entity';

@Entity()
export class Payment {
  @PrimaryGeneratedColumn()
  id_payment: number;

  @Column()
  id_order: number;

  @Column('decimal', { precision: 10, scale: 2 })
  total_amount: number;

  @Column({
    type: 'enum',
    enum: ['banking', 'cash'],
  })
  payment_method: string;

  @Column({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP' })
  payment_date: Date;

  @Column()
  status: string;

  @ManyToOne(() => Order, (order) => order.payments)
  @JoinColumn({ name: 'id_order' })
  order: Order;
}
