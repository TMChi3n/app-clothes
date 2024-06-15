import 'package:clothes_app/view/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../models/products.dart';
import 'appstyle.dart';
import 'newproducts.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
    required Future<List<Products>> male,
  }) : _male = male;

  final Future<List<Products>> _male;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.405,
          child:FutureBuilder<List<Products>>(
            future: _male,
            builder: (context,snapshoot){
              if (snapshoot.connectionState == ConnectionState.waiting){
                return CircularProgressIndicator();
              }
              else if(snapshoot.hasError){
                return Text("Lỗi : ${snapshoot.error}");
              }
              else{
                final male =snapshoot.data;
                return ListView.builder(
                  itemCount: male!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder:(context,index){
                    final product = snapshoot.data![index];
                    return const ProductCard(
                      id_product: "1",
                      name: "Áo Gu-Chì",
                      category: "Áo sơ mi",
                      price: "200000 \$ VND",
                      img_url: "https://firebasestorage.googleapis.com/v0/b/tn252-385da.appspot.com/o/demo.jpg?alt=media&token=02c2e882-ca7c-4a12-91f3-98a4556271a7",
                    );
                  },
                );
              }
            },
          ),
        ),
        Column(
          children: [
            Padding(
              padding:
              const EdgeInsets.fromLTRB(12, 20, 12, 20),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sản phẩm mới",
                    style: appstyle(
                        19, Colors.black, FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(
                        "Xem thêm",
                        style: appstyle(
                            19, Colors.black, FontWeight.w500),
                      ),
                      const Icon(
                        AntDesign.caretright,
                        size: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
          child: FutureBuilder<List<Products>>(
            future: _male,
            builder: (context,snapshoot){
              if (snapshoot.connectionState == ConnectionState.waiting){
                return CircularProgressIndicator();
              }
              else if(snapshoot.hasError){
                return Text("Lỗi : ${snapshoot.error}");
              }
              else{
                final male =snapshoot.data;
                return ListView.builder(
                  itemCount: male!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder:(context,index){
                    final product = snapshoot.data![index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: NewProducts(imageUrl: product.image_Url),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
