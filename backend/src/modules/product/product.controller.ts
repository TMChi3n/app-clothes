import { Body, Controller, Delete, Get, Param, Post, Put } from '@nestjs/common';
import { ProductService } from './product.service';
import { Product } from './entities/product.entity';
import { CreateProductDto } from './dto/create-product.dto';

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

  @Post('/create')
  createProduct(@Body() createProductDto: CreateProductDto): Promise<Product> {
    return this.productService.addProduct(createProductDto);
  }

  @Put('/update/:id')
  updateProduct(@Param('id') id_product: number, @Body() createProductDto: CreateProductDto): Promise<Product> {
    return this.productService.updateProduct(id_product, createProductDto);
  }

  @Delete('/delete/:id')
  deleteProduct(@Param('id') id_product: number): Promise<void> {
    return this.productService.deleteProduct(id_product);
  }
}

