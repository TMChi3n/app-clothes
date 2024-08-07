import {
  IsString,
  IsOptional,
  MinLength,
  MaxLength,
  IsIn,
} from 'class-validator';

export class UpdateUserDto {
  @IsOptional()
  @IsString()
  username?: string;

  @IsOptional()
  @IsString()
  address?: string;

  @IsOptional()
  @IsIn(['Nam', 'Nữ'])
  gender?: 'Nam' | 'Nữ';

  @IsOptional()
  birthday?: Date | string;

  @IsOptional()
  @IsString()
  avatar?: string;

  @IsOptional()
  @IsString()
  @MinLength(10)
  @MaxLength(10)
  phone_number?: number;
}
