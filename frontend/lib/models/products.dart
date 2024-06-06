import 'dart:convert';

List<Products> productFromJson(String str) => List<Products>.from(json.decode(str).map((x) => Products.fromJson(x)));
class Products {
  Products({
    required this.id_product,
    required this.name,
    required this.person,
    required this.material,
    required this.overview,
    required this.price,
    required this.image_Url,
    required this.type,


});
  final int id_product;
  final String name;
  final String person;
  final String material;
  final String overview;
  final double price;
  final String image_Url;
  final String type;
  //
  // Phương thức để chuyển đổi từ JSON sang đối tượng Product
  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      id_product: json['id_product'],
      name: json['name'],
      person: json['person'],
      material: json['material'],
      overview: json['overview'],
      price: json['price'],
      image_Url: json['img_url'],
      type: json['type'],
    );
  }

  // Phương thức để chuyển đổi từ đối tượng Product sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id_product': id_product,
      'name': name,
      'person': person,
      'material': material,
      'overview': overview,
      'price': price,
      'img_url': image_Url,
      'type': type,
    };
  }

  }

