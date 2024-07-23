import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/cart/cart.dart';
import '../../controller/order/order.dart';
import '../../models/cart/cartitems.dart';
import '../../models/product/products.dart';
import '../../services/cart/cart.dart';
import 'ordercreen.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CartNotifier>().getCart();
    });
  }

  double calculateTotalPrice(List<CartItem> cartItems, List<Products> products) {
    return cartItems.fold(0.0, (total, item) {
      final product = products.firstWhere((prod) => prod.id_product == item.idProduct);
      return total + (product.price * item.quantity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text('Giỏ hàng'),
        centerTitle: true,
      ),
      body: Consumer<CartNotifier>(
        builder: (context, cartNotifier, child) {
          if (cartNotifier.cartItems.isEmpty) {
            return const Center(
              child: Text(
                'Giỏ hàng trống',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            );
          }

          return FutureBuilder<List<Products>>(
            future: Future.wait(cartNotifier.cartItems.map((cartItem) => CartService.getProductDetails(cartItem.idProduct))),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final products = snapshot.data!;
              final totalPrice = calculateTotalPrice(cartNotifier.cartItems, products);

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartNotifier.cartItems.length,
                      itemBuilder: (context, index) {
                        final cartItem = cartNotifier.cartItems[index];
                        final product = products.firstWhere((prod) => prod.id_product == cartItem.idProduct);
                        return ListTile(
                          leading: product.imageData.isNotEmpty
                              ? SizedBox(
                            height: 60,
                            width: 60,
                            child: Image.network(
                              String.fromCharCodes(product.imageData),
                              fit: BoxFit.cover,
                            ),
                          )
                              : const Icon(Icons.image),
                          title: Text(
                            product.name,
                            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                          ),

                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Giá: ${product.price} VND', style: const TextStyle(fontSize: 16)),
                              SizedBox(height: 8,),
                              Text('Tổng tiền: ${product.price * cartItem.quantity} VND', style: const TextStyle(fontSize: 16)),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              IconButton(
                                icon: const Icon(Icons.remove, size: 18),
                                onPressed: () => cartNotifier.decreaseQuantity(cartItem.idCartDetail),
                              ),
                              Text('${cartItem.quantity}', style: const TextStyle(fontSize: 17)),
                              IconButton(
                                icon: const Icon(Icons.add, size: 18),
                                onPressed: () => cartNotifier.increaseQuantity(cartItem.idCartDetail),
                              ),
                              SizedBox(width: 3,),
                              IconButton(
                                icon: const Icon(Icons.delete, size: 18),
                                onPressed: () => cartNotifier.removeFromCart(cartItem.idCartDetail),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Thành tiền',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${totalPrice} VND',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  CheckoutSection(totalPrice: totalPrice),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class CheckoutSection extends StatelessWidget {
  final double totalPrice;

  const CheckoutSection({Key? key, required this.totalPrice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () async {
          final bool confirmed = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Xác nhận'),
              content: const Text('Xác nhận mua hàng?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Hủy'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Xác nhận'),
                ),
              ],
            ),
          );

          if (confirmed) {
            final orderNotifier = context.read<OrderNotifier>();
            await orderNotifier.createOrder('cash');
            if (orderNotifier.order != null) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OrderScreen()),
              );
            }
            await context.read<CartNotifier>().getCart();
          }
        },
        child: const Text('Thanh toán'),
      ),
    );
  }
}
