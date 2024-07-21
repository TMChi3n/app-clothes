import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/cart/cartitems.dart';
import '../../services/cart/cart.dart';

class CartNotifier extends ChangeNotifier {
  List<CartItem> _cartItems = [];
  bool _isLoading = false;
  String _errorMessage = '';
  Map<int, bool> _loadingProducts = {};

  List<CartItem> get cartItems => _cartItems;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  Map<int, bool> get loadingProducts => _loadingProducts;

  Future<void> getCart() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final SharedPreferences sharepre = await SharedPreferences.getInstance();
      if (sharepre.getString('access_token') == null) {
        _errorMessage = 'You need to log in to view the cart.';
        _cartItems = [];
      } else {
        _errorMessage = '';
        final cartData = await CartService.getCart();
        _cartItems = (cartData['cartItems'] as List)
            .map((item) => CartItem.fromJson(item))
            .toList();
      }
    } catch (e) {
      _errorMessage = 'Failed to load cart: $e';
      _cartItems = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addToCart(int productId, int quantity) async {
    _loadingProducts[productId] = true;
    notifyListeners();

    try {
      await CartService.addToCart(productId, quantity);
      await _updateCartItem(productId);
    } catch (e) {
      _errorMessage = 'Failed to add to cart';
    } finally {
      _loadingProducts[productId] = false;
      notifyListeners();
    }
  }

  Future<void> removeFromCart(int id) async {
    _loadingProducts[id] = true;
    notifyListeners();

    try {
      await CartService.removeFromCart(id);
      _cartItems.removeWhere((item) => item.idCartDetail == id);
    } catch (e) {
      _errorMessage = 'Failed to remove from cart';
    } finally {
      _loadingProducts[id] = false;
      notifyListeners();
    }
  }

  Future<void> increaseQuantity(int id) async {
    _loadingProducts[id] = true;
    notifyListeners();

    try {
      await CartService.increaseQuantity(id);
      await _updateCartItem(id);
    } catch (e) {
      _errorMessage = 'Failed to increase quantity';
    } finally {
      _loadingProducts[id] = false;
      notifyListeners();
    }
  }

  Future<void> decreaseQuantity(int id) async {
    _loadingProducts[id] = true;
    notifyListeners();

    try {
      await CartService.decreaseQuantity(id);
      await _updateCartItem(id);
    } catch (e) {
      _errorMessage = 'Failed to decrease quantity';
    } finally {
      _loadingProducts[id] = false;
      notifyListeners();
    }
  }

  Future<void> _updateCartItem(int id) async {
    final cartData = await CartService.getCart();
    final updatedItems = (cartData['cartItems'] as List)
        .map((item) => CartItem.fromJson(item))
        .toList();
    final updatedItem =
    updatedItems.firstWhere((item) => item.idCartDetail == id);
    final index = _cartItems.indexWhere((item) => item.idCartDetail == id);
    if (index != -1) {
      _cartItems[index] = updatedItem;
    } else {
      _cartItems.add(updatedItem);
    }
  }

  Future<void> clearCart() async {
    _isLoading = true;
    notifyListeners();

    try {
      await CartService.clearCart();
      _cartItems.clear();
    } catch (e) {
      _errorMessage = 'Failed to clear cart';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
