
import 'package:flutter/material.dart';

class NewProducts extends StatelessWidget {
  const NewProducts({
    super.key, required this.imgData,
  });

  final List<int> imgData;

  @override
  Widget build(BuildContext context) {
    // Chuyển đổi imgData từ danh sách byte thành chuỗi URL
    String urlString = String.fromCharCodes(imgData);
    return Container(
      decoration:const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow:[ BoxShadow(
            color: Colors.white,
            spreadRadius: 5,
            blurRadius: 1,
            offset: Offset(0,1)
        ),
        ],
      ),
      height: MediaQuery.of(context).size.height *
          0.15,
      width: MediaQuery.of(context).size.width *
          0.40,
      child: Image.network(
        urlString,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Center(child: Text('----Lỗi khi load ảnh ở NewProducts: $error------'));
        },
      ),
    );
  }
}
