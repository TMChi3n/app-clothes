import 'dart:convert';

import 'package:clothes_app/services/config.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/orders/order_item_model.dart';
import '../../models/orders/order_model.dart';

class OrderService {
  static Future<Order> createOrder(String paymentMethod) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('access_token') ?? '';
    final int userId = int.parse(prefs.getString('user_id') ?? '0');

    var client = http.Client();
    try {
      var url = Uri.http(Config.apiLocalhost, '/api/v1/order/create');
      var response = await client.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'userId': userId, 'paymentMethod': paymentMethod}),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Order created successfully");
        return Order.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create order');
      }
    } finally {
      client.close();
    }
  }

  static Future<Order> getOrder(int orderId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('access_token') ?? '';

    var client = http.Client();
    try {
      var url = Uri.http(Config.apiLocalhost, '/api/v1/order/$orderId');
      var response = await client.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return Order.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load order');
      }
    } finally {
      client.close();
    }
  }

  static Future<List<Order>> getOrdersByUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('access_token') ?? '';
    final int userId = int.parse(prefs.getString('user_id') ?? '0');

    var client = http.Client();
    try {
      var url = Uri.http(Config.apiLocalhost, '/api/v1/order/user/$userId');
      var response = await client.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        Iterable l = jsonDecode(response.body);
        return List<Order>.from(l.map((model) => Order.fromJson(model)));
      } else {
        throw Exception('Failed to load orders');
      }
    } finally {
      client.close();
    }
  }

  static Future<List<OrderDetail>> getAllOrder(int orderId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('access_token') ?? '';

    var client = http.Client();
    try {
      var url = Uri.http(Config.apiLocalhost, '/api/v1/order');
      var response = await client.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> data = jsonDecode(response.body);
        List<OrderDetail> orders = [];
        for (var item in data) {
          if (item['id_order'] == orderId) {
            orders.add(OrderDetail.fromJson(item));
          }
        }
        return orders;
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      print('Error fetching orders: $e');
      throw Exception('Failed to load orders');
    } finally {
      client.close();
    }
  }
}
