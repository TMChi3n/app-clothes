import { Controller, Get, UseGuards, Req, Param } from '@nestjs/common';
import { JwtAuthGuard } from 'src/common/guards/jwt-auth.guard';
import { UserService } from './user.service';
import { User } from './entities/user.entity';
@Controller('api/v1')
export class UsersController {
  constructor(private userService: UserService) {}

  @UseGuards(JwtAuthGuard)
  @Get('profile')
  getProfile(@Req() req) {
    return req.user;
  }

  @Get('/users')
  async getAllUsers(): Promise<User[]> {
    return await this.userService.getAllUser();
  }

  @Get('/user/:id_user')
  async getUserById(@Param('id_user') id_user: number): Promise<User> {
    return await this.userService.findById(id_user);
  }
}
