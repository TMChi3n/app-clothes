import 'package:flutter/material.dart';
import 'package:clothes_app/view/widgets/appstyle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../widgets/reusable_text.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

                                    ReusableText(
                                          text: "Tên",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 19,
                                              fontStyle: FontStyle.normal)
                                    ),
                                    ReusableText(
                                        text: " Email",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontStyle: FontStyle.italic)
                                    ),

                                  ],
                                ),
                                const Spacer(),
                                    GestureDetector(
                                        onTap: () {
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
                    height: 10.h,
                  ),
                  Container(
                    height: 160.h,
                    color: Colors.grey.shade200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const ReusableText(
                                text: 'Giỏ hàng',
                                style: TextStyle(fontSize: 15,color: Colors.black,fontStyle: FontStyle.normal)
                            ),
                            const Spacer(),
                            GestureDetector(
                                onTap: () {
                                },
                                child: const Icon(Feather.shopping_cart),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const ReusableText(
                                text: 'Yêu thích',
                                style: TextStyle(fontSize: 15,color: Colors.black,fontStyle: FontStyle.normal)
                            ),
                            GestureDetector(
                              onTap: () {
                              },
                              child: const Icon(Feather.heart),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const ReusableText(
                                text: 'Đơn hàng',
                                style: TextStyle(fontSize: 15,color: Colors.black,fontStyle: FontStyle.normal)
                            ),
                            GestureDetector(
                              onTap: () {
                              },
                              child: const Icon(Feather.check),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const ReusableText(
                                text: 'Đăng xuất',
                                style: TextStyle(fontSize: 15,color: Colors.black,fontStyle: FontStyle.normal)
                            ),
                            GestureDetector(
                              onTap: () {
                              },
                              child: const Icon(Feather.log_out),
                            )
                          ],
                        ),

                      ],
                    )
                  ),
                ],

              ),
            ],
          ),
        ));
  }
}
