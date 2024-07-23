// import 'package:flutter/material.dart';
// import '../../models/orders/getoder_res.dart';
//
// import '../../services/oder/order.dart';
// import '../widgets/ordercard.dart';
//
// class OrderPage extends StatefulWidget {
//   @override
//   _OrderPageState createState() => _OrderPageState();
// }
//
// class _OrderPageState extends State<OrderPage> {
//   late Future<List<OrderModel>> _orders;
//
//   @override
//   void initState() {
//     super.initState();
//     _orders = OrderService().fetchOrders();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Order Details'),
//       ),
//       body: FutureBuilder<List<OrderModel>>(
//         future: _orders,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No data available'));
//           }
//
//           final orders = snapshot.data!;
//
//           return ListView.builder(
//             itemCount: orders.length,
//             itemBuilder: (context, index) {
//               final order = orders[index];
//
//               return ExpansionTile(
//                 title: Text('Mã số đơn hàng(ID): ${order.idOrder}'),
//                 subtitle: Text('Trạng thái: ${order.status}'),
//                 children: [
//                   ListTile(
//                     title: Text('Thời gian tạo: ${order.orderDate}'),
//                     subtitle: order.completedDate != null
//                         ? Text('Ngày hoàn thành: ${order.completedDate}')
//                         : null,
//                   ),
//                   ...order.orderItems.map((item) => OrderCard(
//                         item: item,
//                         status: order.status,
//                       )),
//                 ],
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
