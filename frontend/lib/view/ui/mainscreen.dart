import 'package:clothes_app/controller/mainscreen.dart';
import 'package:clothes_app/view/ui/FavPage.dart';
import 'package:clothes_app/view/ui/cart_screen.dart';
import 'package:clothes_app/view/ui/home_screen.dart';
import 'package:clothes_app/view/ui/profilepage.dart';
import 'package:clothes_app/view/ui/searchpage.dart';
import 'package:clothes_app/view/ui/unauthenticated/guest_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/bottom_navi.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  List<Widget> pageList = [
    const HomePage(),
    const FavoPage(),
    const SearchPage(),
    const CartPage(),
    const ProfilePage(),
    const GuestProfile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
      builder: (context, mainScreenNotifier, child) {
        return Scaffold(
          body: pageList[mainScreenNotifier.pageIndex],
          bottomNavigationBar: const BottomNav(),
        );
      },
    );
  }
}
