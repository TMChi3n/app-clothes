
import 'package:clothes_app/view/widgets/appstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/cart/cart.dart';
import '../../controller/favorite/favorites_notifier.dart';
import '../ui/productdetail.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.id_product,
    required this.name,
    required this.type,
    required this.price,
    required this.imgData,
    required this.overview,
  }) : super(key: key);

  final int id_product;
  final String name;
  final String type;
  final double price;
  final List<int> imgData;
  final String overview;

  Future<bool> hasAccessToken() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    final accessToken = sharedPreferences.getString('access_token');
    return accessToken != null && accessToken.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    // Chuyển đổi List<int> imgData thành String để sử dụng trong NetworkImage
    String img_url = String.fromCharCodes(imgData);

    final favoriteNotifier = Provider.of<FavoriteNotifier>(context);
    final cartNotifier = Provider.of<CartNotifier>(context);

    bool isFavorite = favoriteNotifier.favoriteProducts
        .any((product) => product.id_product == id_product);
    bool isFavoriteLoading =
    favoriteNotifier.loadingProducts.contains(id_product);
    bool isCartLoading = cartNotifier.loadingProducts.containsKey(id_product);

    return FutureBuilder<bool>(
      future: hasAccessToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final hasToken = snapshot.data ?? false;

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
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(
                            idProduct: id_product,
                            name: name,
                            imgData: img_url,
                            price: price,
                            type: type,
                            overview: overview,
                          )));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.22,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(img_url),
                              fit: BoxFit.cover,
                              onError: (exception, stackTrace) {
                                print('Error loading image: $exception');
                              },
                            ),
                          ),
                        ),
                        if (hasToken)
                          Positioned(
                            right: 10,
                            top: 10,
                            child: GestureDetector(
                              onTap: () {
                                if (isFavorite) {
                                  favoriteNotifier.removeFavorite(id_product);
                                } else {
                                  favoriteNotifier.addFavorite(id_product);
                                }
                              },
                              child: isFavoriteLoading
                                  ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: const CircularProgressIndicator())
                                  : Icon(
                                isFavorite
                                    ? MaterialCommunityIcons.heart
                                    : MaterialCommunityIcons
                                    .heart_outline,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        // if (hasToken)
                        //   Positioned(
                        //     right: 10,
                        //     bottom: 10,
                        //     child: GestureDetector(
                        //       onTap: () {
                        //         cartNotifier.addToCart(id_product, 1);
                        //       },
                        //       child: isCartLoading
                        //           ? SizedBox(
                        //               height: 20,
                        //               width: 20,
                        //               child: const CircularProgressIndicator())
                        //           : Icon(
                        //               MaterialCommunityIcons.cart,
                        //               color: Colors.blue,
                        //             ),
                        //     ),
                        //   ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: appstyleWithHt(
                              15,
                              Colors.black,
                              FontWeight.bold,
                              1.1,
                            ),
                          ),
                          Text(
                            type,
                            style: appstyleWithHt(
                              18,
                              Colors.grey,
                              FontWeight.bold,
                              1.5,
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
                              17,
                              Colors.green,
                              FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
