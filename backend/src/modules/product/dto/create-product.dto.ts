import { IsNumber, IsString } from 'class-validator';

export class CreateProductDto {
  @IsString()
  name: string;
  @IsString()
  descriptions: string;
  @IsNumber()
  price: number;
  @IsString()
  img_url: string;
  @IsNumber()
  stock_quantity: number;
  @IsString()
  brand: string;
}
