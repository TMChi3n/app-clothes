import 'dart:convert';
import 'package:clothes_app/services/config.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/product/products.dart';

class CartService {
  static Future<Map<String, dynamic>> getCart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('access_token') ?? '';
    String? id_user = prefs.getString('user_id');
    print('user_id : $id_user');
    var client = http.Client();
    try {
      var url = Uri.http(Config.apiLocalhost, '${Config.getCart}/${id_user}');
      var response = await client.get(
        url,
        headers: { 'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
          },
      );

      if (response.statusCode == 200) {
        final bodyresponse = response.body;
        print('Response: $bodyresponse');

        return json.decode(response.body);
      } else {
        throw Exception('Failed to load cart');
      }
    } finally {
      client.close();
    }
  }

  static Future<void> addToCart(int productId, int quantity) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('access_token') ?? '';
    final String userId = prefs.getString('user_id') ?? "0";

    var client = http.Client();
    try {
      var url = Uri.http(Config.apiLocalhost, '${Config.addCart}');
      var response = await client.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(
            {'userId': userId, 'productId': productId, 'quantity': quantity}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Fluttertoast.showToast(msg: "Thêm vào cart thành công");
      } else {
        throw Exception('Failed to add to cart');
      }
    } finally {
      client.close();
    }
  }

  static Future<void> removeFromCart(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('access_token') ?? '';

    var client = http.Client();
    try {
      var url = Uri.http(Config.apiLocalhost, '${Config.getCart}/remove/$id');
      var response = await client.delete(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to remove from cart');
      }
    } finally {
      client.close();
    }
  }

  static Future<void> increaseQuantity(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('access_token') ?? '';

    var client = http.Client();
    try {
      var url =
      Uri.http(Config.apiLocalhost, '${Config.getCart}/increase/$id');
      var response = await client.patch(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to increase quantity');
      }
    } finally {
      client.close();
    }
  }

  static Future<void> decreaseQuantity(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('access_token') ?? '';

    var client = http.Client();
    try {
      var url =
      Uri.http(Config.apiLocalhost, '${Config.getCart}/decrease/$id');
      var response = await client.patch(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to decrease quantity');
      }
    } finally {
      client.close();
    }
  }

  static Future<void> clearCart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('access_token') ?? '';

    var client = http.Client();
    try {
      var url = Uri.http(Config.apiLocalhost, '${Config.getCart}/clear');
      var response = await client.delete(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to clear cart');
      }
    } finally {
      client.close();
    }
  }

  static Future<Products> getProductDetails(int productId) async {
    var client = http.Client();
    var url = Uri.http(Config.apiLocalhost, '/api/v1/product/get/$productId');

    try {
      var response = await client.get(url);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return Products.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load product details');
      }
    } finally {
      client.close();
    }
  }
}