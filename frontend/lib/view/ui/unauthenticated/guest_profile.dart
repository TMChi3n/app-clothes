import 'package:clothes_app/view/ui/loginpage.dart';
import 'package:clothes_app/view/widgets/appstyle.dart';
import 'package:clothes_app/view/widgets/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuestProfile extends StatelessWidget{
   const GuestProfile({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE1E1E1),

      ),
      body:SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 650.h,
            decoration:  const BoxDecoration(
              color:Colors.white,
            ),
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(12, 10, 16, 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        SizedBox(
                          height: 45,
                          width: 45,
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/images/user.png'),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5,bottom: 10),
                          child: ReusableText(text: "Bạn chưa đăng nhập !",
                              style: TextStyle(color: Colors.black,fontSize: 22,
                                  fontStyle: FontStyle.italic)
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage())
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top:7),
                            width: 120,
                            height: 45,
                            decoration: const BoxDecoration(
                                color: Colors.pink,
                                borderRadius: BorderRadius.all(Radius.circular(13))
                            ),
                            child: Center(
                                child: ReusableText(
                                  text: 'Đăng nhập',
                                  style: appstyle(14,Colors.white, FontWeight.bold),
                                )
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),

                ),
              ],

            )

          )
        ],
      ),
    )
    );
  }
}