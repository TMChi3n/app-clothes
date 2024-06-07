import 'package:flutter/material.dart';
import 'package:clothes_app/view/widgets/appstyle.dart';


class SearchPage extends StatefulWidget{
  const SearchPage ({super.key});

  @override
  State<SearchPage> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Trang tìm kiếm',style: appstyle(40, Colors.black, FontWeight.bold),),
      ),
    );
  }

}