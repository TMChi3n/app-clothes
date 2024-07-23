
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/cart/cart.dart';

class ProductDetailScreen extends StatefulWidget {
  final int idProduct;
  final String name;
  final String type;
  final double price;
  final String imgData;
  final String overview;

  const ProductDetailScreen({
    Key? key,
    required this.idProduct,
    required this.name,
    required this.type,
    required this.price,
    required this.imgData,
    required this.overview,
  }) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final cartNotifier = Provider.of<CartNotifier>(context);
    print(widget.imgData);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              height: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(color: Colors.white, spreadRadius: 3),
                ],
                image: DecorationImage(
                  image: NetworkImage(widget.imgData),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(17.0),
              child:
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height:10,),
                      Text(
                        widget.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Thể loại: ${widget.type}',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Giá: ${widget.price}.VND',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text(
                        'Mô tả: ${widget.overview}',
                        style:
                        const TextStyle(fontSize: 16, color: Colors.black),
                      ),

                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  print('id san pham them gio hang ${widget.idProduct}');
                  cartNotifier.addToCart(widget.idProduct, 1);

                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Thêm vào giỏ hàng'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
