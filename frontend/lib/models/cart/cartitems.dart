class CartItem {
  final int idCartDetail;
  final int idCart;
  final int idProduct;
  final int quantity;

  CartItem(
      {required this.idCartDetail,
        required this.idCart,
        required this.idProduct,
        required this.quantity});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      idCartDetail: json['id_cart_detail'],
      idCart: json['id_cart'],
      idProduct: json['id_product'],
      quantity: json['quantity'],
    );
  }
}