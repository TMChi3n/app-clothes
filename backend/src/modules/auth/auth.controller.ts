import {
  Controller,
  Request,
  Post,
  Body,
  UseGuards,
  Param,
  Patch,
  Query,
  Get,
} from '@nestjs/common';
import { AuthService } from './auth.service';
import { LocalAuthGuard } from 'src/common/guards/local-auth.guard';
import { CreateUserDto } from '../user/dto/create-user.dto';
import { ForgotPasswordDto } from './dto/forgot-password.dto';
import { ResetPasswordDto } from './dto/reset-password.dto';
import { UpdateUserDto } from '../user/dto/update-user.dto';
import { JwtAuthGuard } from 'src/common/guards/jwt-auth.guard';
import { RoleGuard } from 'src/common/guards/role-auth.guard';
import { Role } from 'src/common/decorators/role';
import { UpdateRoleDto } from './dto/update-role';
import { ChangePasswordDto } from './dto/change-password';
import { UserProfileDto } from './dto/profile-user';

@Controller('api/v1/auth')
export class AuthController {
  constructor(private authService: AuthService) {}

  @UseGuards(LocalAuthGuard)
  @Post('login')
  async login(@Request() req) {
    return this.authService.login(req.user);
  }

  @Post('register')
  async register(@Body() createUserDto: CreateUserDto) {
    const user = await this.authService.register(createUserDto);
    return {
      message: 'Registration successful. Please check your email.',
      user: {
        username: user.username,
        email: user.email,
        password: user.password,
      },
    };
  }

  @Post('forgot-password')
  @UseGuards(JwtAuthGuard)
  async forgotPassword(@Body() forgotPasswordDto: ForgotPasswordDto) {
    return this.authService.forgotPassword(forgotPasswordDto);
  }

  @Post('reset-password')
  async resetPassword(
    @Query('token') token: string,
    @Body() resetPasswordDto: ResetPasswordDto,
  ) {
    resetPasswordDto.token = token;
    return this.authService.resetPassword(resetPasswordDto);
  }

  @Patch('update-profile/:id')
  @UseGuards(JwtAuthGuard)
  async updateProfile(
    @Param('id') id: number,
    @Body() updateUserDto: UpdateUserDto,
  ) {
    return this.authService.updateUser(id, updateUserDto);
  }

  @Patch('update-role/:id')
  @UseGuards(JwtAuthGuard, RoleGuard)
  @Role('admin')
  async updateRole(
    @Param('id') id: number,
    @Body() updateRoleDto: UpdateRoleDto,
  ) {
    const { role } = updateRoleDto;
    return this.authService.updateRole(id, role);
  }

  @Patch('/change-password/:id')
  @UseGuards(JwtAuthGuard)
  async changePassword(
    @Param('id') id_user: number,
    @Body() changePasswordDto: ChangePasswordDto,
  ): Promise<{ message: string }> {
    return this.authService.changePassword(id_user, changePasswordDto);
  }

  @Get('profile/:id')
  @UseGuards(JwtAuthGuard)
  async viewProfile(@Param('id') id_user: number): Promise<UserProfileDto> {
    return this.authService.viewProfile(id_user);
  }
}
