import 'dart:convert';
import 'package:clothes_app/models/product/products.dart';
import 'package:clothes_app/services/config.dart';
import 'package:http/http.dart' as http;

Future<List<Products>> fetchProducts() async {
  var client  = http.Client();
  var url = Uri.http(Config.apiLocalhost,Config.getAllProduct);
  var response = await client.get(url);
  if (response.statusCode == 200) {
    final List<dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse.map((product) => Products.fromJson(product)).toList();
  } else {
    throw Exception('Failed to load products');
  }
}

