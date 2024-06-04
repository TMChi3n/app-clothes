import { Body, Controller, Get, Post } from '@nestjs/common';
import { ProductService } from './product.service';
import { Product } from './entities/product.entity';
import { CreateProductDto } from './dto/create-product.dto';

@Controller('api/v1/product')
export class ProductController {
  constructor(private readonly productService: ProductService) {}

  @Get('/get/:id')
  getProductById(id_product: number): Promise<Product> {
    return this.productService.findProductById(id_product);
  }

  @Get('/get')
  getAllProducts(): Promise<Product[]> {
    return this.productService.findAllProduct();
  }

  @Post('/create')
  createProduct(@Body() createProductDto: CreateProductDto): Promise<Product> {
    return this.productService.addProduct(createProductDto);
  }
}

