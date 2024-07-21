import 'package:flutter/material.dart';
import '../../models/orders/order_item_model.dart';
import '../../models/orders/order_model.dart';
import '../../services/oder/order.dart';

class OrderNotifier extends ChangeNotifier {
  OrderNotifier();
  Order? _order;
  List<Order>? _userOrders;
  List<OrderDetail>? _userOrdersDetail;
  bool _isLoading = false;

  Order? get order => _order;
  List<OrderDetail>? get userOrdersDetail => _userOrdersDetail;
  List<Order>? get userOrders => _userOrders;
  bool get isLoading => _isLoading;

  Future<void> createOrder(String paymentMethod) async {
    _isLoading = true;
    notifyListeners();

    try {
      _order = await OrderService.createOrder(paymentMethod);
    } catch (e) {
      print(e);
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchOrder(int orderId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _order = await OrderService.getOrder(orderId);
    } catch (e) {
      print(e);
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchUserOrders() async {
    _isLoading = true;
    notifyListeners();

    try {
      _userOrders = await OrderService.getOrdersByUser();
    } catch (e) {
      print(e);
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> getAllOrder(int orderId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _userOrdersDetail = await OrderService.getAllOrder(orderId);
    } catch (e) {
      print(e);
    }

    _isLoading = false;
    notifyListeners();
  }
}
