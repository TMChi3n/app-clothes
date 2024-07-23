class Favorite {
  final int idFavorite;
  final int idUser;
  final int idProduct;

  Favorite({
    required this.idFavorite,
    required this.idUser,
    required this.idProduct,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      idFavorite: json['id_favorite'],
      idUser: json['id_user'],
      idProduct: json['id_product'],
    );
  }
}
