import 'package:clothes_app/view/ui/FavPage.dart';
import 'package:clothes_app/view/ui/cart_screen.dart';
import 'package:clothes_app/view/ui/home_screen.dart';
import 'package:clothes_app/view/ui/profilepage.dart';
import 'package:clothes_app/view/ui/searchpage.dart';
import 'package:clothes_app/view/widgets/appstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clothes_app/ColorsAndOther/AppColors.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:clothes_app/view/widgets/bottom_navi_widget.dart';
class MainScreen extends StatelessWidget{
  MainScreen({super.key});
  List<Widget> pageList = const [
    HomePage(),
    FavoPage(),
    SearchPage(),
    CartPage(),
    ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    int pageIndex = 2;
    return Scaffold(
     backgroundColor: Colors.white,
     body: pageList[pageIndex],
     bottomNavigationBar: SafeArea(
       child: Padding(
         padding: EdgeInsets.all(8),
         child: Container(
           padding: EdgeInsets.all(12),
           margin: EdgeInsets.symmetric(horizontal: 10),
           decoration: BoxDecoration(
             color: AppColors.primaryColor,
             borderRadius: BorderRadius.all(Radius.circular(16))

           ),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               BottomNaviWidget(
                 onTap: (){},
                 icon:MaterialCommunityIcons.home,
               ),
               BottomNaviWidget(
                 onTap: (){},
                 icon:Ionicons.heart,
               ),
               BottomNaviWidget(
                 onTap: (){},
                 icon:Ionicons.search,
               ),
               BottomNaviWidget(
                 onTap: (){},
                 icon:Ionicons.cart,
               ),
               BottomNaviWidget(
                 onTap: (){},
                 icon:Ionicons.person,
               ),
             ],
           ),
         ),
       ),
     ),
   );
  }

}