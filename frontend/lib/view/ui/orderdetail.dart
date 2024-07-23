
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../controller/order/order.dart';
import '../../models/orders/order_item_model.dart';
import '../../models/product/products.dart';
import '../../services/cart/cart.dart';

class OrderDetailScreen extends StatefulWidget {
  final int orderId;

  const OrderDetailScreen({super.key, required this.orderId});

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrderNotifier>().getAllOrder(widget.orderId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết đơn hàng'),
      ),
      body: Consumer<OrderNotifier>(
        builder: (context, orderNotifier, child) {
          final order = orderNotifier.userOrdersDetail;

          if (orderNotifier.isLoading || order == null || order.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          final DateFormat dateFormat = DateFormat('dd-MM-yyyy');

          int totalPrice = order.first.orderItems.sumBy((item) => item.price);
          int totalQuantity =
          order.first.orderItems.sumBy((item) => item.quantity);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Đơn hàng #${order.first.idOrder}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text('Trạng thái: ${order.first.status}'),
                const SizedBox(height: 10),
                Text('Ngày đặt đơn hàng: ${dateFormat.format(order.first.orderDate)}'),
                const SizedBox(height: 10),
                Text('Địa chỉ: ${order.first.orderItems.first.address}'),
                const SizedBox(height: 10),
                Text(
                    'Số điện thoại: ${order.first.orderItems.first.phoneNumber}'),
                const SizedBox(height: 20),
                const Text(
                  'Đơn hàng:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: order.first.orderItems.length,
                  itemBuilder: (context, index) =>
                      OrderItemTile(orderItem: order.first.orderItems[index]),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tổng tiền: $totalPrice VND'),
                    Text('Tổng số lượng: $totalQuantity'),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}

class OrderItemTile extends StatelessWidget {
  final OrderItem orderItem;

  const OrderItemTile({Key? key, required this.orderItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: FutureBuilder<Products>(
        future: CartService.getProductDetails(orderItem.idProduct),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ListTile(
              title: Text('Loading...'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Số lượng: ...'),
                  Text('Giá: ...'),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return ListTile(
              title: const Text('Error loading product'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Số lượng: ${orderItem.quantity}'),
                  Text('Giá: ${orderItem.price}'),
                ],
              ),
            );
          } else {
            final product = snapshot.data!;
            String imgUrl = String.fromCharCodes(product.imageData);
            return ListTile(
              leading: product.imageData.isNotEmpty
                  ? SizedBox(
                height: 60,
                width: 60,
                child: CachedNetworkImage(
                  imageUrl: imgUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                  const CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                  const Icon(Icons.error),
                ),
              )
                  : const Icon(Icons.image),
              title: Text(product.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Số lươngj: ${orderItem.quantity}'),
                  Text('Giá: ${orderItem.price}'),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

extension IterableExtension<T> on Iterable<T> {
  int sumBy(int Function(T) f) => fold(0, (sum, item) => sum + f(item));
}
