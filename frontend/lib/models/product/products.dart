import 'dart:convert';

List<Products> productFromJson(String str) =>
    List<Products>.from(json.decode(str).map((x) => Products.fromJson(x)));

class Products {
  Products({
    required this.id_product,
    required this.name,
    required this.person,
    required this.material,
    required this.overview,
    required this.price,
    required this.imageData,
    required this.type,
  });
  final int id_product;
  final String name;
  final String person;
  final String material;
  final String overview;
  final double price;
  final List<int> imageData;
  final String type;

  factory Products.fromJson(Map<String, dynamic> json) {
    List<int> imgData = [];
    if (json['img_url'] != null && json['img_url']['data'] != null) {
      imgData = List<int>.from(json['img_url']['data']);
    }

    return Products(
      id_product: json['id_product'],
      name: json['name'],
      person: json['person'],
      material: json['material'],
      overview: json['overview'],
      price: double.parse(json['price'].toString()),
      // imageData: ServicesForProduct.ConvertToUin8list(List<int>.from(json['img_']['data'])),
      imageData: imgData,
      type: json['type'],
    );
  }
}
