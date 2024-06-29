import 'package:clothes_app/view/widgets/appstyle.dart';
import 'package:clothes_app/view/widgets/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({
  super.key
});
  @override
  State<LoginPage> createState () => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 50.h,
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 60.h),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ReusableText(
                "Chào mừng bạn !",
                appstyle(30,Colors.white,FontWeight.w500)
            ),
            SizedBox(
              height: 50.h,
            ),
            TextF
          ],
        ),
      ),
    );
  }

}