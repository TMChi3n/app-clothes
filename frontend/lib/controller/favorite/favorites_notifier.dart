import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/product/products.dart';
import '../../services/favorite/favorites.dart';

class FavoriteNotifier extends ChangeNotifier {
  List<Products> _favoriteProducts = [];
  bool _isLoading = false;
  String _errorMessage = '';
  Set<int> _loadingProducts = {};

  List<Products> get favoriteProducts => _favoriteProducts;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  Set<int> get loadingProducts => _loadingProducts;

  Future<void> fetchFavoriteProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      final SharedPreferences sharepre = await SharedPreferences.getInstance();
      if (sharepre.getString('access_token') == null) {
        _errorMessage = 'You need to log in to view favorites.';
        _favoriteProducts = [];
      } else {
        _errorMessage = '';
        _favoriteProducts = await FavoriteService.getFavoritesByUser();
      }
    } catch (e) {
      _errorMessage = 'Failed to load favorite products: $e';
      _favoriteProducts = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addFavorite(int productId) async {
    _loadingProducts.add(productId);
    notifyListeners();

    try {
      await FavoriteService.addFavorite(productId);
      await fetchFavoriteProducts();
      Fluttertoast.showToast(
          msg: "Thêm vào sở thích thành công",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      print('Error adding to favorites: $e');
    }

    _loadingProducts.remove(productId);
    notifyListeners();
  }

  Future<void> removeFavorite(int productId) async {
    _loadingProducts.add(productId);
    notifyListeners();

    try {
      await FavoriteService.removeFavorite(productId);
      await fetchFavoriteProducts();
      Fluttertoast.showToast(
          msg: "Xóa sở thích thành công",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      print('Error removing from favorites: $e');
    }

    _loadingProducts.remove(productId);
    notifyListeners();
  }
}
