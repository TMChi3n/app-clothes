import 'package:clothes_app/controllers/login.dart';
import 'package:clothes_app/view/ui/FavPage.dart';
import 'package:clothes_app/view/ui/cart_screen.dart';
import 'package:clothes_app/view/ui/loginpage.dart';
import 'package:clothes_app/view/ui/unauthenticated/guest_profile.dart';
import 'package:clothes_app/view/ui/updateProfile.dart';
import 'package:clothes_app/view/widgets/optionsOnProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

import '../widgets/reusable_text.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    var notifier = Provider.of<LoginNotifier>(context);
    return notifier.logged == false? GuestProfile():  Scaffold(
      backgroundColor: const Color(0xFFE1E1E1) ,
        appBar: AppBar(
          backgroundColor: const Color(0xFFE1E1E1),
          elevation: 0,
          actions: [
            GestureDetector(
              onTap: () {},
              child: const Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Icon(
                      SimpleLineIcons.settings,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(

                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(12, 10, 16, 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/images/user.png'),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [

                                  ],
                                ),
                                const Spacer(),
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (context)  => UpdateProfile()));
                                        },
                                        child: Icon(Feather.edit_2)
                                    )


                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                            Options(
                              onTap: () {},
                                text: 'Đơn hàng',
                                icon: AntDesign.check,
                            ),
                            Options(
                                onTap: () {
                                  Navigator.push(
                                      context, MaterialPageRoute(
                                    builder: (context) =>const CartPage(),));
                                  },
                                text: 'Giỏ hàng',
                                icon: AntDesign.shoppingcart),
                            Options(
                                onTap: () {
                                  Navigator.push(
                                      context, MaterialPageRoute(
                                      builder: (context) =>const FavoPage()));
                                },
                                text: 'Yêu thích',
                                icon: AntDesign.hearto),
                            Options(
                                onTap: () {},
                                text: 'Địa chỉ giao hàng',
                                icon: SimpleLineIcons.location_pin),

                      ],
                    )
                  ),
                  SizedBox(height: 10),

                  Container(
                    color:  Colors.white,
                    child: Column(
                      children: [
                    Options(
                        onTap: () {
                          notifier.LogOut();
                          Navigator.push(
                            context, MaterialPageRoute(builder:
                          (context) => LoginPage()));
                        },
                        text: 'Đăng xuất',
                        icon: AntDesign.logout),
                   ]
                    ),
                  ),
                ],

              ),
            ],
          ),
        ));
  }
}
