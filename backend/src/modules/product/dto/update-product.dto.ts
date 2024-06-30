import { PartialType } from '@nestjs/mapped-types';
import { CreateProductDto } from './create-product.dto';
import { IsString, IsOptional, IsNumber } from 'class-validator';

export class UpdateProductDto extends PartialType(CreateProductDto) {
    @IsOptional()
    @IsString()
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
    price?: number;
  
    @IsOptional()
    @IsString()
    img_url?: string;
  
    @IsOptional()
    @IsString()
    type?: string;
  }
