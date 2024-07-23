
import 'package:flutter/material.dart';
import 'package:clothes_app/view/widgets/appstyle.dart';
import 'package:clothes_app/view/widgets/product_card.dart';
import 'package:provider/provider.dart';

import '../../controller/search/search.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchNotifier = Provider.of<SearchNotifier>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!searchNotifier.isLoading && searchNotifier.products.isEmpty) {
        searchNotifier.fetchAllProducts();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) => searchNotifier.searchProducts(value),
          decoration: const InputDecoration(
            hintText: 'Tìm kiếm...',
            border: InputBorder.none,
          ),
        ),
        centerTitle: true,
        leading: SizedBox.shrink(),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Consumer<SearchNotifier>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.products.isEmpty) {
            return Center(
              child: Text(
                'Không tìm thấy',
                style: appstyle(20, Colors.black, FontWeight.bold),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: provider.products.length,
              itemBuilder: (context, index) {
                final product = provider.products[index];
                return SizedBox(
                  height: 350,
                  child: ProductCard(
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
