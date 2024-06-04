import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Product } from './entities/product.entity';
import { Repository } from 'typeorm';
import { CreateProductDto } from './dto/create-product.dto';
@Injectable()
export class ProductService {
  constructor(
    @InjectRepository(Product) private productRepo: Repository<Product>,
  ) {}

  async findProductById(id_product: number): Promise<Product> {
    return await this.productRepo.findOne({ where: { id_product } });
  }

  async findAllProduct(): Promise<Product[]> {
    return await this.productRepo.find();
  }

 async addProduct(createProductDto: CreateProductDto): Promise<Product> {
  const { name, descriptions, price, img_url, type } = createProductDto;
  const product = new Product();
  product.name = name;
  product.descriptions = descriptions;
  product.price = price;
  product.img_url = Buffer.from(img_url, 'base64'); 
  product.type = type;

  return await this.productRepo.save(product);
}

async updateProduct(id_product: number, createProductDto: CreateProductDto): Promise<Product> {
  const product = await this.findProductById(id_product);
  const { name, descriptions, price, img_url, type } = createProductDto;
  product.name = name;
  product.descriptions = descriptions;
  product.price = price;
  product.img_url = Buffer.from(img_url, 'base64');
  product.type = type;

  return await this.productRepo.save(product);
}

async deleteProduct(id_product: number): Promise<void> {
  const product = await this.findProductById(id_product);
  await this.productRepo.remove(product);
}

}
