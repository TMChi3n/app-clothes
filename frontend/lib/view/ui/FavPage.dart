import 'package:clothes_app/controllers/favorite/favorites_notifier.dart';
import 'package:clothes_app/controllers/login.dart';
import 'package:flutter/material.dart';
import 'package:clothes_app/view/widgets/appstyle.dart';
import 'package:provider/provider.dart';


class FavoPage extends StatefulWidget{
  const FavoPage ({super.key});

  @override
  State<FavoPage> createState() => FavoPageState();
}

class FavoPageState extends State<FavoPage>{
  @override
  Widget build(BuildContext context) {
    var notifier = Provider.of<LoginNotifier>(context);
    var favNotifier = Provider.of<FavoritesChangeNotifier>(context);
    return Scaffold(
      body: Center(
        child: Text('Trang sản phẩm yêu thích',style: appstyle(40, Colors.black, FontWeight.bold),),
      ),
    );
  }

}