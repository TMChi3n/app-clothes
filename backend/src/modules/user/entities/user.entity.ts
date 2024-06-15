import { Cart } from 'src/modules/cart/entities/cart.entity';
import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from 'typeorm';

@Entity()
export class User {
  @PrimaryGeneratedColumn()
  id_user: number;

  @Column()
  username: string;

  @Column()
  password: string;

  @Column({ unique: true })
  email: string;

  @Column({ type: 'enum', enum: ['admin', 'user'], default: 'user' })
  role: 'admin' | 'user';

  @Column('longblob', { nullable: true })
  avatar: string;

  @Column({ nullable: true })
  resetPasswordToken: string;

  @Column({ nullable: true })
  resetPasswordExpires: Date;

  @Column({ nullable: true })
  address: string;

  @Column({ nullable: true, default: 'empty' })
  gender: string;

  @Column({ nullable: true, type: 'date' })
  birthday: Date;

  @Column({ nullable: true })
  phone_number?: number;

  @OneToMany(() => Cart, (cart) => cart.user)
  carts: Cart[];
}
