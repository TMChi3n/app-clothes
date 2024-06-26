import { Cart } from 'src/modules/cart/entities/cart.entity';
import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from 'typeorm';
import { Order } from 'src/modules/order/entities/order.entity';
import { Favorite } from 'src/modules/favorite/entities/favorite.entity';

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
  avatar: string =
    'https://www.google.com/url?sa=i&url=https%3A%2F%2Fcellphones.com.vn%2Fsforum%2Favatar-trang&psig=AOvVaw1iBY_-RwyiKn2FjCSjqqhL&ust=1719392502598000&source=images&cd=vfe&opi=89978449&ved=0CA8QjRxqFwoTCKji26yy9oYDFQAAAAAdAAAAABAE';

  @Column({ nullable: true })
  resetPasswordToken: string;

  @Column({ nullable: true })
  resetPasswordExpires: Date;

  @Column({ nullable: true })
  address: string;

  @Column({ type: 'enum', enum: ['male', 'female'], nullable: true })
  gender: 'male' | 'female';

  @Column({ nullable: true, type: 'date' })
  birthday: Date;

  @Column({ nullable: true })
  phone_number?: number;

  @OneToMany(() => Cart, (cart) => cart.user)
  carts: Cart[];

  @OneToMany(() => Order, (order) => order.user)
  orders: Order[];

  @OneToMany(() => Favorite, favorite => favorite.user)
  favorites: Favorite[];
}
