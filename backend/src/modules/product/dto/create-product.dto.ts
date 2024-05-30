import { IsNumber, IsString, IsNotEmpty } from 'class-validator';

export class CreateProductDto {
  @IsString()
  @IsNotEmpty()
  name: string;

  @IsString()
  @IsNotEmpty()
  descriptions: string;

  @IsNumber()
  price: number;

  @IsString()
  @IsNotEmpty()
  img_url: string;

  @IsNumber()
  stock_quantity: number;

  @IsString()
  @IsNotEmpty()
  brand: string;
}
