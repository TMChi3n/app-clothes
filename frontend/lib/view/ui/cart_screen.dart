import 'package:clothes_app/models/cart_item.dart';
import 'package:clothes_app/services/cart_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clothes_app/controllers/cart_notifier.dart';
import 'package:clothes_app/models/auth/product/products.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    final cartNotifier = Provider.of<CartNotifier>(context, listen: false);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      cartNotifier.getCart();
    });
  }

  double calculateTotalPrice(
      List<CartItem> cartItems, List<Products> products) {
    double total = 0.0;
    for (var item in cartItems) {
      final product =
          products.firstWhere((prod) => prod.id_product == item.idProduct);
      total += product.price * item.quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final cartNotifier = Provider.of<CartNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
        leading: SizedBox.shrink(),
      ),
      body: Selector<CartNotifier, bool>(
        selector: (context, cartNotifier) => cartNotifier.isLoading,
        builder: (context, isLoading, child) {
          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return cartNotifier.errorMessage.isNotEmpty
              ? Center(
                  child: Text(
                  cartNotifier.errorMessage,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ))
              : cartNotifier.cartItems.isEmpty
                  ? const Center(
                      child: Text(
                      'Your cart is empty',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ))
                  : RefreshIndicator(
                      onRefresh: () async {
                        await cartNotifier.getCart();
                      },
                      child: FutureBuilder<List<Products>>(
                        future: Future.wait(cartNotifier.cartItems
                            .map(
                              (cartItem) => CartService.getProductDetails(
                                  cartItem.idProduct),
                            )
                            .toList()),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (snapshot.hasData) {
                            final products = snapshot.data!;
                            final totalPrice = calculateTotalPrice(
                                cartNotifier.cartItems, products);
                            return Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: cartNotifier.cartItems.length,
                                    itemBuilder: (context, index) {
                                      final cartItem =
                                          cartNotifier.cartItems[index];
                                      final product = products[index];
                                      String img_url = String.fromCharCodes(
                                          product.imageData);
                                      return ListTile(
                                        leading: product.imageData.isNotEmpty
                                            ? Image.network(
                                                img_url,
                                                width: 50,
                                                height: 50,
                                              )
                                            : const Icon(Icons.image),
                                        title: Text(
                                          product.name,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Price: \$${product.price}'),
                                            Text(
                                                'Quantity: ${cartItem.quantity}'),
                                            Text(
                                                'Total Price: \$${product.price * cartItem.quantity}'),
                                          ],
                                        ),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.remove),
                                              onPressed: () {
                                                cartNotifier.decreaseQuantity(
                                                    cartItem.idCartDetail);
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.add),
                                              onPressed: () {
                                                cartNotifier.increaseQuantity(
                                                    cartItem.idCartDetail);
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.delete),
                                              onPressed: () {
                                                cartNotifier.removeFromCart(
                                                    cartItem.idCartDetail);
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        'Total: \$${totalPrice.toStringAsFixed(2)}',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10),
                                      ElevatedButton(
                                        onPressed: () {
                                          print('Proceed to Checkout');
                                        },
                                        child: Text('Proceed to Checkout'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      ),
                    );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          cartNotifier.clearCart();
        },
        child: const Icon(Icons.clear),
      ),
    );
  }
}
