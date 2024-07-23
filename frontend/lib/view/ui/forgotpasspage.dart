
import 'package:clothes_app/view/widgets/reusable_text.dart';
import 'package:clothes_app/view/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/user/forgotpass.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ForgotNotifier(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Quên mật khẩu'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const ReusableText(
                  text: 'Khi gửi yêu cầu thành công, liên kết lấy lại mật khẩu sẽ được gửi đến email!',
                  style: TextStyle(fontStyle: FontStyle.normal),
                ),
                const SizedBox(height: 100),
                CustomTextField(
                  controller: _emailController,
                  hintText: 'Nhập email đăng kí tài khoản tại đây',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Consumer<ForgotNotifier>(
                  builder: (context, controller, child) {
                    return controller.isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() == true) {
                          controller.sendForgotPasswordRequest(_emailController.text).then((success) {
                            // if (success == true) {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     const SnackBar(content: Text('Yêu cầu thành công, vui lòng kiểm tra email.')),
                            //   );
                            // } else {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     const SnackBar(content: Text('Gửi email khôi phục mật khẩu thất bại.')),
                            //   );
                            // }
                          });
                        }
                      },
                      child: const Text('Gửi yêu cầu', selectionColor: Colors.black),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
