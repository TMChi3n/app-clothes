class Order {
  final int idOrder;
  final int idUser;
  final String status;
  final DateTime orderDate;
  final DateTime? completedDate;

  Order({
    required this.idOrder,
    required this.idUser,
    required this.status,
    required this.orderDate,
    this.completedDate,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      idOrder: json['id_order'],
      idUser: json['id_user'],
      status: json['status'],
      orderDate: DateTime.parse(json['order_date']),
      completedDate: json['completed_date'] != null
          ? DateTime.parse(json['completed_date'])
          : null,
    );
  }
}
