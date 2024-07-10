import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'appstyle.dart';


class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.id_product,
    required this.name,
    required this.type,
    required this.price,
    required this.imgData,
  }) : super(key: key);

  final int id_product;
  final String name;
  final String type ;
  final double price;
  final List<int> imgData;

  @override
  Widget build(BuildContext context) {
    // In ra dữ liệu của ảnh trước khi hiển thị
    String img_url = String.fromCharCodes(imgData);
    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 20, 7, 0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.4,
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.white,
              spreadRadius: 7,
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
          ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.16,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(img_url),
                        fit: BoxFit.cover,
                        onError: (exception, stackTrace) {
                          print('-----Lỗi khi load ảnh : $exception----------');
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: GestureDetector(
                      onTap: () {},
                      child: Icon(MaterialCommunityIcons.heart_outline),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 10, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: appstyleWithHt(
                        15, Colors.black, FontWeight.w700, 1.07,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8,top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${price}',
                      style: appstyle(
                        17, Colors.green, FontWeight.w500,
                      ),
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
