import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../controllers/login.dart';
import '../widgets/appstyle.dart';
import '../widgets/reusable_text.dart';
import '../widgets/textfield.dart';

class Registor extends StatefulWidget{
  const Registor({super.key});
  @override
  State<Registor> createState() => _RegistorState();

}
class _RegistorState extends State<Registor>{
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();

  @override
  Widget build(BuildContext context){
    var auNotifi = Provider.of<LoginNotifier>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 40.h,
        backgroundColor: Colors.blue,
      ),
      body:
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 70.h),
        decoration: const BoxDecoration(
            image:DecorationImage(
                opacity: 0.8,
                image: AssetImage('assets/images/background_login.png')
            )
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ReusableText(
                text: "Chào mứng bạn đăng ký tài khoản !",
                style: appstyle(23,Colors.black, FontWeight.w600)
            ),

            SizedBox(
              height: 70.h,
            ),
            CustomTextField(
              keyboardType: TextInputType.emailAddress,
              controller: username,
              hintText: 'Tên người dùng ',
              validator: (username){
                if(username!.isEmpty){
                  return "Vui lòng không bỏ trống tên";
                }else{
                  return null;
                }
              },
            ),
              SizedBox(
              height: 10.h,
            ),
            CustomTextField(
              keyboardType: TextInputType.emailAddress,
              controller: email,
              hintText: 'Email ',
              validator: (email){
                if(email!.isEmpty){
                  return "Email không được bỏ trống";
                }
                else if(!email.contains("@")){
                  return "Email không hợp lệ";
                }
                else{
                  return null;
                }
              },
            ),
            SizedBox(
              height: 10.h,
            ),
            CustomTextField(
              obscureText: auNotifi.isObsecure,
              controller: password,
              hintText: "Password",
              suffixIcon: GestureDetector(
                onTap:(){
                  auNotifi.isObsecure = !auNotifi.isObsecure;
                },
                child:auNotifi.isObsecure? const Icon(Icons.visibility):const Icon(Icons.visibility),

              ),
              validator: (password){
                if(password!.isEmpty){
                  return "Mật khẩu không được để trống!";
                }else if(password.length < 8){
                  return "Mật khẩu phải có 8 kí tự ";
                }else{
                  return null;
                }
              },
            ),
            SizedBox(
              height: 20.h,
            ),

            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap:(){

                },
                child: ReusableText(
                  text:"Đã có tài khoản ?",
                  style: appstyle(12, Colors.black,FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: (){

              },
              child: Container(
                height: 55.h,
                width: 300,
                decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                child: Center(
                  child: ReusableText(
                    text:"Đăng kí tài khoản",
                    style: appstyle(18,Colors.white,FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}