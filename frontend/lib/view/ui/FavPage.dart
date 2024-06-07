import 'package:flutter/material.dart';
import 'package:clothes_app/view/widgets/appstyle.dart';


class FavoPage extends StatefulWidget{
  const FavoPage ({super.key});

  @override
  State<FavoPage> createState() => FavoPageState();
}

class FavoPageState extends State<FavoPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Trang sản phẩm yêu thích',style: appstyle(40, Colors.black, FontWeight.bold),),
      ),
    );
  }

}