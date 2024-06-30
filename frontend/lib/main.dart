import 'package:clothes_app/controllers/login.dart';
import 'package:clothes_app/controllers/mainscreen.dart';
import 'package:clothes_app/controllers/product.dart';
import 'package:clothes_app/view/ui/mainscreen.dart';
import 'package:clothes_app/view/ui/profilepage.dart';
import 'package:clothes_app/view/ui/unauthenticated/guest_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [
      ChangeNotifierProvider(create: (context) => MainScreenNotifier()),
      ChangeNotifierProvider(create: (context) => ProductNotifier()),
      ChangeNotifierProvider(create: (context) => LoginNotifier()),
  ],
  child: const MyApp()));
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});
  @override
  Widget build (BuildContext context){
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context , child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Siu!!!',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),

            // sets the homescreen of the app
            home:const ProfilePage(),
          );
        }
    );
  }

}
