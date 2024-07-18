import 'package:clothes_app/models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:clothes_app/services/cart_service.dart';

class CartNotifier extends ChangeNotifier {
  List<CartItem> _cartItems = [];
  bool _isLoading = false;
  String _errorMessage = '';
  Set<int> _loadingProducts = {};

  List<CartItem> get cartItems => _cartItems;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  Set<int> get loadingProducts => _loadingProducts;

  Future<void> getCart() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final cartData = await CartService.getCart();
      _cartItems = (cartData['cartItems'] as List)
          .map((item) => CartItem.fromJson(item))
          .toList();
    } catch (e) {
      _errorMessage = 'Failed to load cart';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addToCart(int productId, int quantity) async {
    _loadingProducts.add(productId);
    notifyListeners();

    try {
      await CartService.addToCart(productId, quantity);
      await getCart();
    } catch (e) {
      _errorMessage = 'Failed to add to cart';
    }

    _loadingProducts.remove(productId);
    notifyListeners();
  }

  Future<void> removeFromCart(int id) async {
    _loadingProducts.add(id);
    notifyListeners();

    try {
      await CartService.removeFromCart(id);
      await getCart();
    } catch (e) {
      _errorMessage = 'Failed to remove from cart';
    }

    _loadingProducts.remove(id);
    notifyListeners();
  }

  Future<void> increaseQuantity(int id) async {
    _loadingProducts.add(id);
    notifyListeners();

    try {
      await CartService.increaseQuantity(id);
      await getCart();
    } catch (e) {
      _errorMessage = 'Failed to increase quantity';
    }

    _loadingProducts.remove(id);
    notifyListeners();
  }

  Future<void> decreaseQuantity(int id) async {
    _loadingProducts.add(id);
    notifyListeners();

    try {
      await CartService.decreaseQuantity(id);
      await getCart();
    } catch (e) {
      _errorMessage = 'Failed to decrease quantity';
    }

    _loadingProducts.remove(id);
    notifyListeners();
  }

  Future<void> clearCart() async {
    _isLoading = true;
    notifyListeners();

    try {
      await CartService.clearCart();
      await getCart();
    } catch (e) {
      _errorMessage = 'Failed to clear cart';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
