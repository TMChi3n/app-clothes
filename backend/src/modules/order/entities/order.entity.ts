import { Column, Entity, JoinColumn, ManyToOne, OneToMany, PrimaryGeneratedColumn } from 'typeorm';
import { User } from 'src/modules/user/entities/user.entity';
import { OrderItem } from '../order-item/entities/order-item.entity';
import { Payment } from 'src/modules/payment/etities/payment.entity';
@Entity()
export class Order {
  @PrimaryGeneratedColumn()
  id_order: number;

  @Column()
  id_user: number;

  @Column({
    type: 'enum',
    enum: ['pending', 'processing', 'completed', 'cancelled']
  })
  status: string;

  @Column()
  order_date: Date;

  @Column({ nullable: true })
  completed_date: Date;

  @ManyToOne(() => User, (user) => user.orders)
  @JoinColumn({ name: 'id_user' })
  user: User;

  @OneToMany(() => OrderItem, (orderItem) => orderItem.order)
  orderItems: OrderItem[];

  @OneToMany(() => Payment, (payment) => payment.order)  
  payments: Payment[];
}
