import { Entity, PrimaryGeneratedColumn, ManyToOne, JoinColumn } from 'typeorm';
import { User } from 'src/modules/user/entities/user.entity';
import { Product } from 'src/modules/product/entities/product.entity';

@Entity()
export class Favorite {
  @PrimaryGeneratedColumn()
  id_favorite: number;

  @ManyToOne(() => User, user => user.favorites)
  @JoinColumn({ name: 'id_user' })
  user: User;

  @ManyToOne(() => Product, product => product.favorites)
  @JoinColumn({ name: 'id_product' })
  product: Product;
}
