import { IsNumber, IsString, IsNotEmpty } from 'class-validator';

export class CreateProductDto {
  @IsString()
  @IsNotEmpty()
  name: string;

  @IsString()
  @IsNotEmpty()
  material: string;

  @IsString()
  @IsNotEmpty()
  overview: string;

  @IsNumber()
  price: number;

  @IsString()
  @IsNotEmpty()
  img_url: string;

  @IsString()
  @IsNotEmpty()
  type: string;

  @IsString()
  @IsNotEmpty()
  person: string;
}
