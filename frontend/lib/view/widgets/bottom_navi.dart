import 'package:clothes_app/view/widgets/bottom_navi_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:clothes_app/controllers/mainscreen_notifier.dart';

class BottomNav extends StatelessWidget{
  const BottomNav({
    super.key,
});
  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
      builder: (context,mainScreenNotifier,child){
        return SafeArea(child: Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            padding: EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
              color: Colors.black,
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
                    mainScreenNotifier.pageIndex == 1;
                  },
                  icon: mainScreenNotifier.pageIndex == 1
                      ?Ionicons.search
                      :Ionicons.search,
                ),
                BottomNaviWidget()
              ],
            ),
            ),
          ),
        );
      }
    );

  }

}