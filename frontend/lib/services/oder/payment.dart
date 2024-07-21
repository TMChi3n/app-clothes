import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/orders/payment_response.dart';

class PaymentService {
  final String apiUrl = 'http://10.0.2.2:8080/api/v1/payment/create-payment-link';

  Future<PaymentResponse?> createPaymentLink(int orderId) async {
    final SharedPreferences shar = await SharedPreferences.getInstance();
    final String? token = shar.getString('access_token');
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: json.encode({'orderId': orderId}),
        headers: {'Content-Type': 'application/json',
        'Authorization':'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return PaymentResponse.fromJson(data);
      } else {
        // Log thông tin lỗi chi tiết từ phản hồi
        final errorMessage = 'Error ${response.statusCode}: ${response.reasonPhrase}';
        print('Failed to create payment link. Response body: ${response.body}');
        throw Exception(errorMessage);
      }
    } catch (e) {
      // In lỗi chi tiết hơn ra console
      print('Exception caught: $e');
      return null;
    }
  }
}
