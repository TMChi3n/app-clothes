import 'package:cached_network_image/cached_network_image.dart';
import 'package:clothes_app/controller/product.dart';
import 'package:clothes_app/services/servicesForHome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

import '../../models/product/products.dart';

class Productpage extends StatefulWidget{
  const Productpage({super.key, required this.id, required this.type});
  final int id;
  final String type;
  @override
  State<Productpage> createState() => _ProductPageState();

}
class _ProductPageState extends State<Productpage>{
  final PageController pageController = PageController();
  late Future<Products> _product;

  void getProduct(){
    if(widget.type == 'male'){
      _product = Helper().getProductForMaleById(widget.id);
    }else if(widget.type == 'female'){
      _product = Helper().getProductForFeMaleById(widget.id);
    }
    else {
      _product = Helper().getProductForKidById(widget.id);
    }
  }
  @override
  void initState() {
    super.initState();
    getProduct();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Products>(
        future: _product,
        builder: (context,snapshoot)
        {
          if (snapshoot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          else if (snapshoot.hasError) {
            return Text("Lỗi : ${snapshoot.error}");
          }
          else {
            final product = snapshoot.data;
            return Consumer<ProductNotifier>(
              builder: (context, productNotifier, child) {
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      leadingWidth: 0,
                      title: Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: null,
                              child: const Icon(AntDesign.close),
                            ),
                            GestureDetector(
                              onTap: null,
                              child: const Icon(AntDesign.close),
                            ),
                          ],
                        ),
                      ),
                      pinned: true,
                      snap: false,
                      floating: false,
                      backgroundColor: Colors.transparent,
                      expandedHeight: MediaQuery
                          .of(context)
                          .size
                          .height,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          children: [
                            SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.35,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              child: PageView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: product!.imageData.length,
                                  controller: pageController,
                                  itemBuilder: (context, int index) {
                                    return Stack(
                                      children: [
                                        Container(
                                          height: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.35,
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width,
                                          color: Colors.grey.shade50,
                                          // child: CachedNetworkImage(
                                          // //    imageUrl: product.imageData.,
                                          //     fit: BoxFit.contain),
                                        ),
                                        Positioned(
                                            top: MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.09,
                                            right: 20,
                                            child: Icon(
                                              AntDesign.hearto, color: Colors.blue,)
                                        ),
                                      ],
                                    );
                                  }
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }

}