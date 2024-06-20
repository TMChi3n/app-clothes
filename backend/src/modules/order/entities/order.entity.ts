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

  @Column()
  status: string;

  @Column()
  order_date: Date;

  @Column({ nullable: true })
  completed_date: Date;

  @Column({nullable: true}) 
  address: string;

  @Column({nullable: true})
  phone_number: number;

  @ManyToOne(() => User, (user) => user.orders)
  @JoinColumn({ name: 'id_user' })
  user: User;

  @OneToMany(() => OrderItem, (orderItem) => orderItem.order)
  orderItems: OrderItem[];

  @OneToMany(() => Payment, (payment) => payment.order)  
  payments: Payment[];
}
