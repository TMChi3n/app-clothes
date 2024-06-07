import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from './entities/user.entity';
import { Repository } from 'typeorm';
import * as bcrypt from 'bcrypt';

@Injectable()
export class UserService {
  constructor(@InjectRepository(User) private userRepo: Repository<User>) {}

  async register(
    username: string,
    email: string,
    password: string,
    avatar: string,
    role: string = 'USER',
  ): Promise<User> {
    const hashPassword = await bcrypt.hash(password, 10);
    const newUser = this.userRepo.create({
      username,
      email,
      password: hashPassword,
      role,
      avatar,
    } as Partial<User>);
    return this.userRepo.save(newUser);
  }

  async findByEmail(email: string): Promise<User> {
    return this.userRepo.findOne({ where: { email } });
  }

  async findById(id_user: number): Promise<User> {
    return this.userRepo.findOne({ where: { id_user } });
  }
}
