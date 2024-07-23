import { IsOptional, IsString, IsIn } from 'class-validator';

export class UpdateRoleDto {
  @IsOptional()
  @IsString()
  @IsIn(['user', 'admin'])
  role?: 'user' | 'admin';
}
