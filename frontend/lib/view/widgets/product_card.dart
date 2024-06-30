import 'dart:typed_data';

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
    print('Data của ảnh: $imgData');
    String img_url = String.fromCharCodes(imgData);
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 15, 20, 0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.6,
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
              color: CupertinoColors.white,
              spreadRadius: 1,
              blurRadius: 0.6,
              offset: Offset(1, 1),
            ),
          ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.23,
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
                padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: appstyleWithHt(
                        15, Colors.black, FontWeight.bold, 1.1,
                      ),
                    ),
                    Text(
                      type,
                      style: appstyleWithHt(
                        18, Colors.grey, FontWeight.bold, 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${price.toStringAsFixed(3)}',
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
