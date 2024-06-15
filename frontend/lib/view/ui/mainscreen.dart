
import 'package:clothes_app/controllers/mainscreen_notifier.dart';
import 'package:clothes_app/view/ui/FavPage.dart';
import 'package:clothes_app/view/ui/cart_screen.dart';
import 'package:clothes_app/view/ui/home_screen.dart';
import 'package:clothes_app/view/ui/profilepage.dart';
import 'package:clothes_app/view/ui/searchpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/bottom_navi.dart';

class MainScreen extends StatelessWidget{
  MainScreen({super.key});
  List<Widget> pageList =  [
  const  HomePage(),
  const  FavoPage(),
  const  SearchPage(),
    CartPage(),
  const  ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
      builder: (context,mainScreenNotifier, child) {
        return Scaffold(
          body: pageList[mainScreenNotifier.pageIndex],
          bottomNavigationBar: const BottomNav(),
        );
      },
    );


  }

}