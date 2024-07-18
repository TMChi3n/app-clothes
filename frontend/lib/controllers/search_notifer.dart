import 'package:clothes_app/services/favorite_service.dart';
import 'package:clothes_app/services/search_service.dart';
import 'package:flutter/material.dart';
import 'package:clothes_app/models/auth/product/products.dart';

class SearchNotifier extends ChangeNotifier {
  List<Products> _allProducts = [];
  List<Products> _filteredProducts = [];
  bool _isLoading = false;

  List<Products> get products => _filteredProducts;
  bool get isLoading => _isLoading;

  Future<void> fetchAllProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _allProducts = await fetchProducts();
      _filteredProducts = _allProducts;
    } catch (e) {
      print('Error fetching products: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      _filteredProducts = _allProducts;
    } else {
      _filteredProducts = _allProducts
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  Future<void> addToFavorites(Products product) async {
    try {
      await FavoriteService.addFavorite(product.id_product);
      notifyListeners();
    } catch (e) {
      print('Error adding to favorites: $e');
    }
  }
}
