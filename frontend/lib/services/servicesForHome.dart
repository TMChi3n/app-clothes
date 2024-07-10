import 'package:clothes_app/models/auth/product/products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' as the_bundle;
import 'package:http/http.dart' as http;
import 'package:clothes_app/services/config.dart';

class Helper{
  static var client  = http.Client();
  static const String logTag = 'ProductsHelper';

  // Danh mục cho male
  Future<List<Products>> getProductForMale() async {
    var url = Uri.http(Config.apiLocalhost,Config.getAllProduct);
    var response = await client.get(url);

    if (response.statusCode == 200) {

      final maleList = productFromJson(response.body);
      var profmale = maleList.where((element) => element.person == 'male');
      // Print to Logcat with tag
      debugPrint('$logTag: ${profmale.toList()}');
      return profmale.toList();
    } else {
      throw Exception("Lỗi khi lấy sản phẩm cho male");
    }
  }

  // Danh mục cho female
  Future<List<Products>> getProductForFemale() async{
      var url = Uri.http(Config.apiLocalhost,Config.getAllProduct);
      var response = await client.get(url);

      if(response.statusCode ==  200){
        final maleList = productFromJson(response.body);
        var profmale = maleList.where((element) => element.person == 'female');
        return profmale.toList();
      }else{
        throw Exception("Lỗi khi lấy sản phẩm cho female");

      }
  }
  // Danh mục cho children
  Future<List<Products>> getProductForChildre () async{
    var url = Uri.http(Config.apiLocalhost,Config.getAllProduct);
    var response = await client.get(url);

    if(response.statusCode ==  200){
      final maleList = productFromJson(response.body);
      var profmale = maleList.where((element) => element.person == 'children');
      return profmale.toList();
    }else{
      throw Exception("Lỗi khi lấy sản phẩm cho female");

    }
  }
  // For Male by Id_product
  Future<Products> getProductForMaleById(int id_product) async {
    final data =
    await the_bundle.rootBundle.loadString("");

    final maleList = productFromJson(data);

    final product = maleList.firstWhere((product) => product.id_product == id_product);

    return product;
  }
  // For Female by Id_product
  Future<Products> getProductForFeMaleById(int id_product) async {
    final data =
    await the_bundle.rootBundle.loadString("");

    final maleList = productFromJson(data);

    final product = maleList.firstWhere((product) => product.id_product == id_product);

    return product;
  }
  // For kid by Id_product
  Future<Products> getProductForKidById(int id_product) async {
    final data =
    await the_bundle.rootBundle.loadString("");

    final maleList = productFromJson(data);

    final product = maleList.firstWhere((product) => product.id_product == id_product);

    return product;
  }
}
