import 'package:clothes_app/controller/user/changepassword.dart';
import 'package:clothes_app/view/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChangePasswordNotifier(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Đổi mật khẩu'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 30,top: 10,right: 30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(
                  controller: _emailController,
                  hintText: 'Nhập email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập email';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                CustomTextField(
                  controller: _currentPasswordController,
                  hintText: 'Nhập mật khẩu hiện tại',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập mật khẩu hiện tại';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                CustomTextField(
                  controller: _newPasswordController,
                  hintText: 'Nhập mật khẩu mới',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập mật khẩu mới';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Consumer<ChangePasswordNotifier>(
                  builder: (context, controller, child) {
                    return controller.isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() == true) {
                          controller.changePassword(
                            _emailController.text,
                            _currentPasswordController.text,
                            _newPasswordController.text,
                          ).then((success) {
                            if (success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Đổi mật khẩu thành công')),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Đổi mật khẩu thất bại')),
                              );
                            }
                          });
                        }
                      },
                      child: const Text('Đổi mật khẩu'),
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
