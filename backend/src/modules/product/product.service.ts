import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Product } from './entities/product.entity';
import { Repository } from 'typeorm';
import { CreateProductDto } from './dto/create-product.dto';
import { UpdateProductDto } from './dto/update-product.dto';
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
    const { name, person, material, overview, price, img_url, type } =
      createProductDto;
    const product = new Product();
    product.name = name;
    product.person = person;
    product.material = material;
    product.overview = overview;
    product.price = price;
    product.img_url = img_url;
    product.type = type;

    return await this.productRepo.save(product);
  }

  async updateProduct(
    id_product: number,
    updateProductDto: UpdateProductDto,
  ): Promise<Product> {
    const product = await this.findProductById(id_product);

    for (const [key, value] of Object.entries(updateProductDto)) {
      if (value !== undefined) {
        product[key] = value;
      }
    }

    return await this.productRepo.save(product);
  }

  async deleteProduct(id_product: number): Promise<void> {
    const product = await this.findProductById(id_product);
    await this.productRepo.remove(product);
  }

  async filterProducts(
    [],
    priceMin?: number,
    priceMax?: number,
    type?: string,
    person?: string,
  ): Promise<Product[]> {

    if (priceMin === undefined && priceMax === undefined && type === undefined && person === undefined) {
      return [];
    }
    
    let filteredProducts = await this.productRepo.find();

    if (priceMin !== undefined && priceMax !== undefined) {
      filteredProducts = filteredProducts.filter(
        (product) => product.price >= priceMin && product.price <= priceMax,
      );
    }

    if (type) {
      filteredProducts = filteredProducts.filter(
        (product) => product.type === type,
      );
    }

    if (person) {
      filteredProducts = filteredProducts.filter(
        (product) => product.person === person,
      );
    }

    return filteredProducts;
  }

  async searchProductsByName(keyword: string): Promise<Product[]> {
    return await this.productRepo
      .createQueryBuilder('product')
      .where('LOWER(product.name) LIKE LOWER(:keyword)', {
        keyword: `%${keyword}%`,
      })
      .getMany();
  }
}
