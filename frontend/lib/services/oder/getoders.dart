import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/orders/getoder_res.dart';

class GetOrderService {
  final String apiUrl = 'http://10.0.2.2:8080/api/v1/order/user';

  Future<List<OrderModel>> fetchOrders() async {
    final SharedPreferences shar = await SharedPreferences.getInstance();
    final int? orderId = shar.getInt('user_id');
    final String? token = shar.getString('access_token');

    if (orderId == null) {
      throw Exception('User ID not found in SharedPreferences');
    }

    if (token == null) {
      throw Exception('Bearer Token not found in SharedPreferences');
    }

    final response = await http.get(
      Uri.parse('$apiUrl/$orderId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((data) => OrderModel.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }
}
