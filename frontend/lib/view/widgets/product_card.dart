import 'package:clothes_app/view/widgets/appstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class ProductCard extends StatefulWidget {
  const ProductCard(
      {super.key,
      required this.id_product,
      required this.name,
      required this.category,
      required this.price,
      required this.img_url});

  final String id_product;
  final String name;
  final String category;
  final String price;
  final String img_url;
  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool selected = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 15, 20, 0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.6,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: CupertinoColors.white,
                spreadRadius: 1,
                blurRadius: 0.6,
                offset: Offset(1, 1)),
          ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.23,
                    decoration: BoxDecoration(
                      image:
                          DecorationImage(image: NetworkImage(widget.img_url)),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: GestureDetector(
                      onTap: null,
                      child: Icon(MaterialCommunityIcons.heart_outline),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(8, 8, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.name,
                        style: appstyleWithHt(
                            25, Colors.black, FontWeight.bold, 1.1)
                    ),
                    Text(widget.category,
                        style: appstyleWithHt(
                            18, Colors.grey, FontWeight.bold, 1.5)
                    ),
                  ],
                ),
              ),
              Padding(
                padding:EdgeInsets.only(left:8,right:8),
                child: Row(
                  mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.price, style: appstyle(20, Colors.black,FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
