import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from '../user/entities/user.entity';
import { Repository } from 'typeorm';
import { JwtService } from '@nestjs/jwt';
import { ConfigService } from '@nestjs/config';
import { CreateUserDto } from '../user/dto/create-user.dto';
import * as bcrypt from 'bcrypt';
import * as nodemailer from 'nodemailer';

@Injectable()
export class AuthService {
  constructor(
    @InjectRepository(User) private userRepo: Repository<User>,
    private jwtService: JwtService,
    private configService: ConfigService,
  ) {}

  async register(createUserDto: CreateUserDto): Promise<User> {
    const { username, email, password } = createUserDto;
    const hashPass = await bcrypt.hash(password, 10);
    const user = this.userRepo.create({
      username,
      email,
      password: hashPass,
    });
    const savedUser = await this.userRepo.save(user);
    // Adding send mail
    this.sendConfirmationEmail(email);
    return savedUser;
  }

  async validateUser(email: string, password: string): Promise<any> {
    const user = await this.userRepo.findOne({ where: { email } });
    if (user && (await bcrypt.compare(password, user.password))) {
      return {
        id_user: user.id_user,
        username: user.username,
        email: user.email,
        role: user.role,
      };
    }
    return null;
  }

  async login(user: any) {
    const payload = { email: user.email, sub: user.id_user, role: user.role };
    return {
      access_token: this.jwtService.sign(payload, { expiresIn: '2h' }),
      refresh_token: this.jwtService.sign(payload, { expiresIn: '30d' }),
      data: {
        email: user.email,
        username: user.username,
        role: user.role,
      },
    };
  }

  private async sendConfirmationEmail(email: string) {
    const transporter = nodemailer.createTransport({
      service: 'gmail',
      auth: {
        user: this.configService.get('EMAIL_USER'),
        pass: this.configService.get('EMAIL_PASSWORD'),
      },
    });

    const mailOptions = {
      from: this.configService.get('EMAIL_USER'),
      to: email,
      subject: 'Welcome to Our App!',
      text: 'Thank you for registering!',
    };

    await transporter.sendMail(mailOptions);
  }
}
