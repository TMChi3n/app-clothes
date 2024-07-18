import 'package:clothes_app/view/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clothes_app/controllers/favorite_notifier.dart';

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
        title: const Text('Favorite Products'),
        centerTitle: true,
        leading: SizedBox.shrink(),
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
                'No favorite products found',
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
                  child: ProductCard(
                    name: product.name,
                    id_product: product.id_product,
                    type: product.type,
                    price: product.price,
                    imgData: product.imageData,
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
