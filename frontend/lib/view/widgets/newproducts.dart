import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NewProducts extends StatelessWidget {
  const NewProducts({
    super.key, required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
        boxShadow:[ BoxShadow(
            color: Colors.white,
            spreadRadius: 2,
            blurRadius: 1,
            offset: Offset(0,1)
        ),
        ],
      ),
      height: MediaQuery.of(context).size.height *
          0.12,
      width: MediaQuery.of(context).size.width *
          0.28,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
      ),
    );
  }
}