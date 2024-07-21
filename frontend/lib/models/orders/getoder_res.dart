class OrderItemModel {
  final int idOrderDetail;
  final int idOrder;
  final int idProduct;
  final int quantity;
  final int price;
  final String address;
  final String phoneNumber;

  OrderItemModel({
    required this.idOrderDetail,
    required this.idOrder,
    required this.idProduct,
    required this.quantity,
    required this.price,
    required this.address,
    required this.phoneNumber,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      idOrderDetail: json['id_order_detail'],
      idOrder: json['id_order'],
      idProduct: json['id_product'],
      quantity: json['quantity'],
      price: json['price'],
      address: json['address'],
      phoneNumber: json['phone_number'].toString(), // Chuyển đổi phone_number sang String nếu cần
    );
  }
}

 // Import lớp OrderItemModel

class OrderModel {
  final int idOrder;
  final int idUser;
  final String status;
  final DateTime orderDate;
  final DateTime? completedDate;
  final List<OrderItemModel> orderItems;

  OrderModel({
    required this.idOrder,
    required this.idUser,
    required this.status,
    required this.orderDate,
    this.completedDate,
    required this.orderItems,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      idOrder: json['id_order'],
      idUser: json['id_user'],
      status: json['status'],
      orderDate: DateTime.parse(json['order_date']),
      completedDate: json['completed_date'] != null
          ? DateTime.parse(json['completed_date'])
          : null,
      orderItems: (json['orderItems'] as List<dynamic>)
          .map((item) => OrderItemModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

