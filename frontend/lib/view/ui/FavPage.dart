import 'package:clothes_app/controller/favorite/favorites_notifier.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../widgets/favoritescard.dart';

class FavoPage extends StatelessWidget {
  const FavoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriteNotifier =
    Provider.of<FavoriteNotifier>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      favoriteNotifier.fetchFavoriteProducts();
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        elevation: 0,
        toolbarHeight: 20.h,
        title: const Text('Yêu thích'),
        leading: SizedBox.shrink(),
        centerTitle: true,
      ),
      body: Consumer<FavoriteNotifier>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.errorMessage.isNotEmpty) {
            return Center(
              child: Text(
                provider.errorMessage,
                style:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            );
          } else if (provider.favoriteProducts.isEmpty) {
            return const Center(
              child: Text(
                'Không có sản phẩm yêu thích',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: provider.favoriteProducts.length,
              itemBuilder: (context, index) {
                final product = provider.favoriteProducts[index];
                return SizedBox(
                  height: 350,
                  child: ProductFavCard(
                    name: product.name,
                    id_product: product.id_product,
                    type: product.type,
                    price: product.price,
                    imgData: product.imageData,
                    overview: product.overview,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
