class OrderDetail {
  final int idOrder;
  final int idUser;
  final String status;
  final DateTime orderDate;
  final DateTime? completedDate;
  final List<OrderItem> orderItems;

  OrderDetail({
    required this.idOrder,
    required this.idUser,
    required this.status,
    required this.orderDate,
    this.completedDate,
    required this.orderItems,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    List<OrderItem> items = [];
    if (json['orderItems'] != null) {
      items = List<OrderItem>.from(
        json['orderItems'].map((item) => OrderItem.fromJson(item)),
      );
    }
    return OrderDetail(
      idOrder: json['id_order'],
      idUser: json['id_user'],
      status: json['status'],
      orderDate: DateTime.parse(json['order_date']),
      completedDate: json['completed_date'] != null
          ? DateTime.parse(json['completed_date'])
          : null,
      orderItems: items,
    );
  }
}

class OrderItem {
  final int idOrderDetail;
  final int idOrder;
  final int idProduct;
  final int quantity;
  final int price;
  final String address;
  final int phoneNumber;

  OrderItem({
    required this.idOrderDetail,
    required this.idOrder,
    required this.idProduct,
    required this.quantity,
    required this.price,
    required this.address,
    required this.phoneNumber,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      idOrderDetail: json['id_order_detail'],
      idOrder: json['id_order'],
      idProduct: json['id_product'],
      quantity: json['quantity'],
      price: json['price'],
      address: json['address'],
      phoneNumber: json['phone_number'],
    );
  }
}
