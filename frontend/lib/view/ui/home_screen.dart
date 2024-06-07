import 'package:flutter/material.dart';
import 'package:clothes_app/view/widgets/appstyle.dart';


class HomePage extends StatefulWidget{
  const HomePage ({super.key});
  
  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Trang chur',style: appstyle(40, Colors.black, FontWeight.bold),),
      ),
    );
  }

}