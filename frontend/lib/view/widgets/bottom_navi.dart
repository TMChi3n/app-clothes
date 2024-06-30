import 'package:clothes_app/view/widgets/bottom_navi_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import '../../controllers/mainscreen.dart';


class BottomNav extends StatelessWidget{
  static const Color primaryColor = Color(0xFFBE60DD);
  const BottomNav({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
        builder: (context,mainScreenNotifier,child){
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                padding: EdgeInsets.all(12),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BottomNaviWidget(
                      onTap: () {
                        mainScreenNotifier.pageIndex = 0;
                      },
                      icon: mainScreenNotifier.pageIndex == 0
                          ?MaterialCommunityIcons.home
                          :MaterialCommunityIcons.home_outline,
                    ),
                    BottomNaviWidget(
                      onTap:(){
                        mainScreenNotifier.pageIndex = 1;
                      },
                      icon: mainScreenNotifier.pageIndex == 1
                          ?Ionicons.heart
                          :Ionicons.heart_outline,
                    ),
                    BottomNaviWidget(
                      onTap:(){
                        mainScreenNotifier.pageIndex = 2;
                      },
                      icon: mainScreenNotifier.pageIndex == 2
                          ?Ionicons.search
                          :Ionicons.search,
                    ),
                    BottomNaviWidget(
                      onTap:(){
                        mainScreenNotifier.pageIndex = 3;
                      },
                      icon: mainScreenNotifier.pageIndex == 3
                          ?Ionicons.cart
                          :Ionicons.cart_outline,
                    ),
                    BottomNaviWidget(
                      onTap:(){
                        mainScreenNotifier.pageIndex = 4;
                      },
                      icon: mainScreenNotifier.pageIndex == 4
                          ?Ionicons.person
                          :Ionicons.person_outline,
                    )
                  ],
                ),
              ),
            ),
          );
        }
    );

  }

}