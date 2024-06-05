import { Controller, Get, Param } from '@nestjs/common';
import { ProductService } from './product.service';
import { Product } from './entities/product.entity';

@Controller('api/v1/product')
export class ProductController {
  constructor(private readonly productService: ProductService) {}

  @Get('/get/:id')
  getProductById(@Param('id') id_product: number): Promise<Product> {
    return this.productService.findProductById(id_product);
  }

  @Get('/get')
  getAllProducts(): Promise<Product[]> {
    return this.productService.findAllProduct();
  }
}
