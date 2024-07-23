import 'package:clothes_app/controller/auth/login.dart';
import 'package:clothes_app/models/auth/login/login_request.dart';
import 'package:clothes_app/view/ui/forgotpasspage.dart';
import 'package:clothes_app/view/ui/mainscreen.dart';
import 'package:clothes_app/view/ui/registerpage.dart';
import 'package:clothes_app/view/widgets/appstyle.dart';
import 'package:clothes_app/view/widgets/reusable_text.dart';
import 'package:clothes_app/view/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isValid = false; // biến này dùng để xác thực có hợp lẹe để yêu cầu đăng nhập hay k

  void toConfirm() {

      if (email.text.isNotEmpty && password.text.isNotEmpty) {
        isValid = true;
      } else {
        isValid = false;
      }
  }

  @override
  Widget build(BuildContext context) {
    var notifier = Provider.of<LoginNotifier>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 40.h,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 70.h),
        decoration: const BoxDecoration(
            image: DecorationImage(
                opacity: 0.8,
                image: AssetImage('assets/images/background_login.png'))),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ReusableText(
                text: "Đăng nhập!",
                style: appstyle(33, Colors.black, FontWeight.w600)),
            SizedBox(
              height: 70.h,
            ),
            CustomTextField(
              keyboardType: TextInputType.emailAddress,
              controller: email,
              hintText: 'Email ',
              validator: (email) {
                if (email!.isEmpty) {
                  return "Email không được bỏ trống";
                } else if (!email.contains("@")) {
                  return "Email không hợp lệ";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 10.h,
            ),
            CustomTextField(
              obscureText: notifier.isObsecure,
              controller: password,
              hintText: "Mật khẩu ",
              suffixIcon: GestureDetector(
                onTap: () {
                  notifier.isObsecure = !notifier.isObsecure;
                },
                child: notifier.isObsecure
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility),
              ),
              validator: (password) {
                if (password!.isEmpty) {
                  return "Mật khẩu không được để trống!";
                } else if (password.length < 8) {
                  return "Mật khẩu phải có 8 kí tự ";
                } else {
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
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Registor()));
                },
                child: ReusableText(
                  text: "Chưa có tài khoản ?",
                  style: appstyle(12, Colors.black, FontWeight.bold),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,MaterialPageRoute(builder: ((context) =>const ForgotPasswordPage())) );
                },
                child: ReusableText(
                  text: "Quên mật khẩu ?",
                  style: appstyle(12, Colors.black, FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                toConfirm();
                if (isValid == true) {
                  debugPrint("Xác nhận chuẩn bị đăng nhập");
                  debugPrint("Email: ${email.text}");
                  debugPrint("Password: ${password.text}");
                  LoginModel model = LoginModel(
                      email: email.text,
                      password: password.text);
                  notifier.userLogin(model).then((response){
                    if(response == true){
                    Navigator.push(
                        context,MaterialPageRoute(
                        builder: (context) => MainScreen()));

                    }else{
                      debugPrint('Đăng nhập không thành công ');
                    }
                  });
                } else{
                  debugPrint("Chưa thể yêu cầu đăng nhập");
                  debugPrint("Email: ${email.text}");
                  debugPrint("Password: ${password.text}");
                }
              },
              child: Container(
                height: 55.h,
                width: 300,
                decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Center(
                  child: ReusableText(
                    text: "Đăng  nhập ",
                    style: appstyle(18, Colors.white, FontWeight.bold),
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
