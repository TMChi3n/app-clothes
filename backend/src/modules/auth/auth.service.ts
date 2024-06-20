import {
  BadRequestException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from '../user/entities/user.entity';
import { Repository } from 'typeorm';
import { JwtService } from '@nestjs/jwt';
import { ConfigService } from '@nestjs/config';
import { CreateUserDto } from '../user/dto/create-user.dto';
import * as bcrypt from 'bcrypt';
import * as nodemailer from 'nodemailer';
import { UserService } from '../user/user.service';
import { ForgotPasswordDto } from './dto/forgot-password.dto';
import * as crypto from 'crypto';
import { ResetPasswordDto } from './dto/reset-password.dto';
import { UpdateUserDto } from '../user/dto/update-user.dto';

@Injectable()
export class AuthService {
  constructor(
    @InjectRepository(User) private userRepo: Repository<User>,
    private jwtService: JwtService,
    private configService: ConfigService,
    private userService: UserService,
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
    this.sendConfirmationEmail(email, username);
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
        avatar: user.avatar,
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

  private async sendConfirmationEmail(email: string, username: string) {
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
      text: `Thank you ${username} for register account in my Application`,
    };

    await transporter.sendMail(mailOptions);
  }

  async forgotPassword(forgotPassword: ForgotPasswordDto) {
    const user = await this.userService.findByEmail(forgotPassword.email);
    if (!user) {
      throw new NotFoundException('User not found');
    }

    const token = crypto.randomBytes(20).toString('hex');
    user.resetPasswordToken = token;
    user.resetPasswordExpires = new Date(Date.now() + 3600000); // 1 hour

    await this.userService.save(user);

    const resetUrl = `http://localhost:3000?token=${token}`;

    const transporter = nodemailer.createTransport({
      service: 'gmail',
      auth: {
        user: this.configService.get('EMAIL_USER'),
        pass: this.configService.get('EMAIL_PASSWORD'),
      },
    });

    const mailOptions = {
      from: this.configService.get('EMAIL_USER'),
      to: user.email,
      subject: 'Password Reset Request',
      text: `You are receiving this because you (or someone else) have requested the reset of the password for your account.\n\n
             Please click on the following link, or paste this into your browser to complete the process:\n\n
             ${resetUrl}\n\n
             If you did not request this, please ignore this email and your password will remain unchanged.\n`,
    };

    await transporter.sendMail(mailOptions);

    return { message: 'Password reset email sent' };
  }

  async resetPassword(resetPasswordDto: ResetPasswordDto) {
    const { email, token, newPassword, confirmPassword } = resetPasswordDto;

    const user = await this.userService.findByEmail(email);
    if (
      !user ||
      user.resetPasswordToken !== token ||
      user.resetPasswordExpires < new Date()
    ) {
      throw new BadRequestException(
        'Password reset token is invalid or expired. Please try again',
      );
    }

    if (newPassword !== confirmPassword) {
      throw new BadRequestException('Passwords do not match');
    }

    user.password = await bcrypt.hash(newPassword, 10);
    user.resetPasswordExpires = null;
    user.resetPasswordToken = null;
    await this.userService.save(user);
    return { message: 'Password has been reset' };
  }

  async updateUser(
    id_user: number,
    updateUserDto: UpdateUserDto,
  ): Promise<User> {
    const user = await this.userRepo.findOne({ where: { id_user } });
    if (!user) {
      throw new NotFoundException('User not found');
    }

    // Update only the provided fields in DTO
    const updateUser = { ...user };
    if (updateUserDto.username) {
      updateUser.username = updateUserDto.username;
    }

    if (updateUserDto.avatar) {
      updateUser.avatar = updateUserDto.avatar;
    }
    if (updateUserDto.gender) {
      updateUser.gender = updateUserDto.gender;
    }
    if (updateUserDto.birthday) {
      updateUser.birthday = new Date(updateUserDto.birthday);
    }
    if (updateUserDto.address) {
      updateUser.address = updateUserDto.address;
    }
    if (updateUserDto.phone_number) {
      updateUser.phone_number = updateUserDto.phone_number;
    }

    await this.userRepo.save(updateUser);
    return updateUser;
  }
}
