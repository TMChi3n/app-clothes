import 'package:clothes_app/controller/auth/login.dart';
import 'package:clothes_app/controller/user/user_provider.dart';
import 'package:clothes_app/view/ui/FavPage.dart';
import 'package:clothes_app/view/ui/cart_screen.dart';
import 'package:clothes_app/view/ui/changepasspage.dart';
import 'package:clothes_app/view/ui/forgotpasspage.dart';
import 'package:clothes_app/view/ui/loginpage.dart';
import 'package:clothes_app/view/ui/ordercreen.dart';
import 'package:clothes_app/view/ui/orderlistpage.dart';
import 'package:clothes_app/view/ui/unauthenticated/guest_profile.dart';
import 'package:clothes_app/view/ui/updateProfile.dart';
import 'package:clothes_app/view/widgets/appstyle.dart';
import 'package:clothes_app/view/widgets/optionsOnProfilePage.dart';
import 'package:clothes_app/view/widgets/profile_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/reusable_text.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  String username = '......';
  String address = '...';
  String gender = '.';
  String birthday = '.';
  int phoneNumber = 0000;

  bool flag = false;
  bool _showProfile = false;
  Future<void> loadProfile() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    setState(() {
      username = shared.getString('username') ?? '';
      birthday = shared.getString('birthday') ?? '';
      gender = shared.getString('gender') ?? '';
      phoneNumber = shared.getInt('phone_number') ?? 000;
      address = shared.getString('address') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    var notifier = Provider.of<LoginNotifier>(context);
    var usernotifier = Provider.of<UserProvider>(context);
    return notifier.logged == false
        ? const GuestProfile()
        : Scaffold(
            backgroundColor: const Color(0xFFF3F2F2),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
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
                          padding: const EdgeInsets.fromLTRB(12, 1, 16, 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Row(
                                children: [
                                  Expanded(
                                      child: Align(
                                    child: Text('Trang cá nhân'),
                                  ))
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: IconButton(
                                        onPressed: () async {
                                          setState(() {
                                            _showProfile = !_showProfile;
                                            // Đảo ngược trạng thái khi nhấn nút
                                          });
                                          if (_showProfile) {
                                            setState(() {
                                              flag = true;
                                            });
                                            bool response =
                                                await usernotifier.GetProfile();
                                            flag = false;
                                            if (response) {
                                              await loadProfile();
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content: Text(
                                                        'Tải thông tin bị lỗi')),
                                              );
                                            }
                                          } else {
                                            setState(() {
                                              _showProfile = !_showProfile;
                                            });
                                          }
                                        },
                                        icon: Icon(
                                          _showProfile
                                              ? Icons.arrow_circle_down_sharp
                                              : Icons.arrow_circle_up_sharp,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: _showProfile ? 270.h : 0,
                            child: flag
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : _showProfile
                                    ? Container(
                                        color: Colors.white,
                                        child: ListView(
                                          children: [
                                            ProfileField(
                                                icon: Icons.person,
                                                value: 'Tên: $username'),
                                            ProfileField(
                                                icon: Icons.date_range,
                                                value: 'Ngày sinh: $birthday'),
                                            ProfileField(
                                                icon: Icons.person_2,
                                                value: 'Giới tính: $gender'),
                                            ProfileField(
                                                icon: Icons.phone,
                                                value:
                                                    'Số điện thoại: $phoneNumber'),
                                            ProfileField(
                                                icon: Icons.location_pin,
                                                value: 'Địa chỉ: $address'),
                                          ],
                                        ),
                                      )
                                    : Container())
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 12.h,
                      ),
                      Container(
                          padding: const EdgeInsets.only(left: 9),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  ReusableText(
                                      text: 'Tùy chọn',
                                      style: appstyle(
                                          15, Colors.black, FontWeight.w600)),
                                ],
                              ),
                              Options(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const OrderScreen()));
                                },
                                text: 'Đơn hàng',
                                icon: Icons.check_circle,
                              ),
                              Options(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const CartPage(),
                                        ));
                                  },
                                  text: 'Giỏ hàng',
                                  icon: AntDesign.shoppingcart),
                              Options(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const FavoPage()));
                                  },
                                  text: 'Yêu thích',
                                  icon: AntDesign.hearto),
                              Options(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const UpdateProfile()));
                                  },
                                  text: 'Cập nhật trang cá nhân',
                                  icon: Icons.edit_attributes_outlined),
                            ],
                          )),
                      const SizedBox(height: 5),
                      Container(
                        padding: const EdgeInsets.only(left: 9),
                        color: Colors.white,
                        child: Column(children: [
                          Options(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgotPasswordPage()));
                              },
                              text: 'Quên mật khẩu',
                              icon: Icons.password_outlined),
                          Options(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>const ChangePasswordPage())
                                );
                              },
                              text: 'Đổi mật khẩu',
                              icon: Icons.change_circle),
                          Options(
                              onTap: () {
                                notifier.LogOut();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()));
                              },
                              text: 'Đăng xuất',
                              icon: Icons.logout),
                        ]),
                      ),
                    ],
                  ),
                ],
              ),
            ));
  }
}
