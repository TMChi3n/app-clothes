import 'package:clothes_app/view/ui/home_screen.dart';
import 'package:clothes_app/view/ui/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build (BuildContext context){
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context , child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'dbestech',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),

            // sets the homescreen of the app
            home: MainScreen(),
          );
        }
    );
  }

}
