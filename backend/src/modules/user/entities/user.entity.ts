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

  @OneToMany(() => Cart, (cart) => cart.user)
  carts: Cart[];
}
