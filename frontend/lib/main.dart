import 'package:clothes_app/controller/cart/cart.dart';
import 'package:clothes_app/controller/search/search.dart';
import 'package:clothes_app/controller/user/changepassword.dart';
import 'package:clothes_app/controller/favorite/favorites_notifier.dart';
import 'package:clothes_app/controller/user/forgotpass.dart';
import 'package:clothes_app/controller/auth/login.dart';
import 'package:clothes_app/controller/mainscreen.dart';
import 'package:clothes_app/controller/order/order.dart';
import 'package:clothes_app/controller/product.dart';
import 'package:clothes_app/controller/user/user_provider.dart';
import 'package:clothes_app/view/ui/mainscreen.dart';
import 'package:clothes_app/view/ui/orderlistpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => MainScreenNotifier()),
    ChangeNotifierProvider(create: (context) => ProductNotifier()),
    ChangeNotifierProvider(create: (context) => LoginNotifier()),
    ChangeNotifierProvider(create: (context) => UserProvider()),
    ChangeNotifierProvider(create: (context) => FavoriteNotifier()),
    ChangeNotifierProvider(create: (context) => ForgotNotifier()),
    ChangeNotifierProvider(create: (context) => ChangePasswordNotifier()),
    ChangeNotifierProvider(create: (context) => CartNotifier(),),
    ChangeNotifierProvider(create: (context) => OrderNotifier(),),
    ChangeNotifierProvider(create: (context) => SearchNotifier())
    //ChangeNotifierProvider(create: (context) => OrderNotifier())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Siu!!!',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),

            // sets the homescreen of the app
            home: MainScreen(),
            // onGenerateRoute: (settings) {
            //   if (settings.name == '/orders') {
            //     return MaterialPageRoute(builder: (context) => OrderPage());
            //   }
            //   return null;
            // },
          );
        });
  }
}
