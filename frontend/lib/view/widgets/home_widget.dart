import 'package:clothes_app/controller/product.dart';
import 'package:clothes_app/view/ui/productpage.dart';
import 'package:clothes_app/view/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import '../../models/product/products.dart';
import 'appstyle.dart';
import 'newproducts.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
    required Future<List<Products>> male
  }) : _male = male;

  final Future<List<Products>> _male;
  // final int tabIndex;
  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.36,
          child:FutureBuilder<List<Products>>(
            future: _male,
            builder: (context,snapshoot){
              if (snapshoot.connectionState == ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator.adaptive());
              }
              else if(snapshoot.hasError){
                return Text("Lỗi : ${snapshoot.error}");
              }else if(!snapshoot.hasData || snapshoot.data!.isEmpty){
                return const Center(child: Text("Không có dữ liệu"));
              }
              else{
                final male =snapshoot.data;
                return ListView.builder(
                  itemCount: male!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder:(context,index){
                    final product = snapshoot.data![index];
                    return GestureDetector(
                      onTap:(){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>Productpage(
                                    id: product.id_product,
                                    type: product.type)
                            )
                        );
                      },
                      child: ProductCard(
                        name: product.name,
                        id_product: product.id_product,
                        type: product.type,
                        price:product.price,
                        imgData: product.imageData,
                        overview: product.overview,
                      ),

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
              const EdgeInsets.fromLTRB(12, 15, 12,5),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sản phẩm mới",
                    style: appstyle(
                        17, Colors.black, FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(
                        "Xem thêm",
                        style: appstyle(
                            15, Colors.blue.shade500, FontWeight.w500),
                      ),
                      const Icon(
                        AntDesign.caretright,
                        size: 15,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.28,
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
                      padding: const EdgeInsets.all(10.0),
                      child: NewProducts(imgData: product.imageData),
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
