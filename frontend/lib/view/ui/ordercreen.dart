import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/order/order.dart';
import 'orderdetail.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<OrderNotifier>(context, listen: false).fetchUserOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: Consumer<OrderNotifier>(
        builder: (context, orderNotifier, child) {
          if (orderNotifier.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (orderNotifier.userOrders == null ||
              orderNotifier.userOrders!.isEmpty) {
            return const Center(child: Text('No orders found.'));
          }

          return ListView.builder(
            itemCount: orderNotifier.userOrders!.length,
            itemBuilder: (context, index) {
              final order = orderNotifier.userOrders![index];
              return ListTile(
                title: Text('Order #${order.idOrder}'),
                subtitle: Text('Status: ${order.status}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          OrderDetailScreen(orderId: order.idOrder),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
