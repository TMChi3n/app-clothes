import { PartialType } from '@nestjs/mapped-types';
import { CreateProductDto } from './create-product.dto';
import { IsString, IsOptional, IsNotEmpty, IsNumber } from 'class-validator';

export class UpdateProductDto extends PartialType(CreateProductDto) {
    @IsOptional()
    @IsString()
    @IsNotEmpty()
    name?: string;
  
    @IsOptional()
    @IsString()
    person?: string;
  
    @IsOptional()
    @IsString()
    material?: string;
  
    @IsOptional()
    @IsString()
    overview?: string;
  
    @IsOptional()
    @IsNumber()
    @IsNotEmpty()
    price?: number;
  
    @IsOptional()
    @IsString()
    @IsNotEmpty()
    img_url?: string;
  
    @IsOptional()
    @IsString()
    @IsNotEmpty()
    type?: string;
  }
