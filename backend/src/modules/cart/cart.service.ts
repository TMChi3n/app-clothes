import { Injectable } from '@nestjs/common';
import { Cart } from './entities/cart.entity';
import { Repository } from 'typeorm';
import { CartItem } from './cart-item/entities/cart-item.entity';
import { InjectRepository } from '@nestjs/typeorm';
@Injectable()
export class CartService {
  constructor(
    @InjectRepository(Cart) private cartRepo: Repository<Cart>,
    @InjectRepository(CartItem)
    private cartItemRepo: Repository<CartItem>,
  ) {}

  async getCart(userId: number) {
    return this.cartRepo.findOne({
      where: { id_user: userId },
      relations: ['cartItems'],
    });
  }

  async addToCart(userId: number, productId: number, quantity: number) {
    let cart = await this.cartRepo.findOne({ where: { id_user: userId } });
    if (!cart) {
      cart = await this.cartRepo.save({ id_user: userId });
    }
    const cartItem = await this.cartItemRepo.findOne({
      where: { id_cart: cart.id_cart, id_product: productId },
    });
    if (cartItem) {
      cartItem.quantity += quantity;
      return this.cartItemRepo.save(cartItem);
    } else {
      return this.cartItemRepo.save({
        id_cart: cart.id_cart,
        id_product: productId,
        quantity,
      });
    }
  }

  async removeFromCart(cartItemId: number) {
    return this.cartItemRepo.delete(cartItemId);
  }

  async increaseQuantity(cartItemId: number) {
    const cartItem = await this.cartItemRepo.findOne({
      where: { id_cart_detail: cartItemId },
    });
    if (cartItem) {
      cartItem.quantity += 1;
      return this.cartItemRepo.save(cartItem);
    }
    throw new Error('Cart item not found');
  }

  async decreaseQuantity(cartItemId: number) {
    const cartItem = await this.cartItemRepo.findOne({
      where: { id_cart_detail: cartItemId },
    });
    if (cartItem) {
      if (cartItem.quantity > 1) {
        cartItem.quantity -= 1;
        if (cartItem.quantity == 0) {
          return this.cartItemRepo.delete(cartItem);
        }
        return this.cartItemRepo.save(cartItem);
      } else {
        return this.removeFromCart(cartItemId);
      }
    }
    throw new Error('Cart item not found');
  }
}
