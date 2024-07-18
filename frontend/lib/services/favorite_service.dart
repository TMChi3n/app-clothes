import 'dart:convert';
import 'package:clothes_app/models/auth/product/products.dart';
import 'package:http/http.dart' as http;
import 'package:clothes_app/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  static Future<void> addFavorite(int productId) async {
    final SharedPreferences sharepre = await SharedPreferences.getInstance();

    var client = http.Client();
    var url = Uri.https(Config.apiLocalhost, 'api/v1/favorite/$productId/add');
    try {
      var response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${sharepre.getString("access_token")}',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
      } else {
        throw Exception('Failed to add product to favorites');
      }
    } finally {
      client.close();
    }
  }

  static Future<void> removeFavorite(int productId) async {
    final SharedPreferences sharepre = await SharedPreferences.getInstance();
    var client = http.Client();
    var url =
        Uri.https(Config.apiLocalhost, 'api/v1/favorite/$productId/remove');

    try {
      var response = await client.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${sharepre.getString("access_token")}',
        },
      );

      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to remove product from favorites');
      }
    } finally {
      client.close();
    }
  }

  static Future<List<Products>> getFavoritesByUser() async {
    final SharedPreferences sharepre = await SharedPreferences.getInstance();
    var client = http.Client();
    var url = Uri.https(Config.apiLocalhost, Config.getFavorite);

    try {
      var response = await client.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${sharepre.getString("access_token")}',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse
            .map((product) => Products.fromJson(product))
            .toList();
      } else {
        throw Exception('Failed to load favorite products');
      }
    } finally {
      client.close();
    }
  }
}
