import 'package:flutter/material.dart';
import 'package:clothes_app/view/widgets/appstyle.dart';


class CartPage extends StatefulWidget{
  const CartPage ({super.key});

  @override
  State<CartPage> createState() => CartPageState();
}

class CartPageState extends State<CartPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Trang giỏ hàng',style: appstyle(40, Colors.black, FontWeight.bold),),
      ),
    );
  }

}