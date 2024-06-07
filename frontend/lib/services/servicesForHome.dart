import 'package:clothes_app/models/products.dart';
import 'package:flutter/services.dart' as the_budle;
import 'package:clothes_app/models/orders/clothes_model.dart';
import 'package:http/http.dart' as http;
import 'package:clothes_app/services/config.dart';

class Helper{
  static var client  = http.Client();

  // Danh mục cho male
  Future<List<Products>> getProductForMale() async {
    var url = Uri.http(Config.apiLocalhost, Config.getAllProduct);
    var response = await client.get(url);

    if (response.statusCode == 200) {
      final maleList = productFromJson(response.body);
      var profmale = maleList.where((element) => element.person == 'male');
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
}
