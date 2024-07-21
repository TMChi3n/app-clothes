import 'package:clothes_app/controller/user/user_provider.dart';
import 'package:clothes_app/models/user/update_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clothes_app/view/widgets/appstyle.dart';
import 'package:clothes_app/view/widgets/reusable_text.dart';
import 'package:clothes_app/view/widgets/textfield.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<StatefulWidget> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController birthday = TextEditingController();
  TextEditingController avatar = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController username = TextEditingController();

  bool isValid = false;
  static const List<String> genderOptions = <String>['Nam','Nữ'];
  String selectGender = genderOptions.first ;
  void toConfirm() {
    isValid = true;
    if (gender.text.isNotEmpty) {
      isValid = false;
    }
    if (phoneNumber.text.isNotEmpty && phoneNumber.text.length < 10) {
      isValid = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var usernotifier = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 40.h,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
          children: [
            ReusableText(
                text: 'Cập nhật thông tin của bạn',
                style: appstyle(18, Colors.black, FontWeight.w700)),
            const SizedBox(
              height: 20,
            ),
            ReusableText(
                text: 'Cập nhật địa chỉ của bạn',
                style: appstyle(15, Colors.black54, FontWeight.w700)),
            CustomTextField(
                controller: address,
                hintText: " địa chỉ, ví dụ : Quận 9, TP HCM"),
            const SizedBox(
              height: 20,
            ),
            ReusableText(
                text: 'Cập nhật số điện thoại',
                style: appstyle(15, Colors.black54, FontWeight.w700)),
            CustomTextField(
                controller: phoneNumber, hintText: " Ví dụ : 087834***090"),
            const SizedBox(
              height: 20,
            ),
            ReusableText(
                text: 'Giới tính của bạn',
                style: appstyle(15, Colors.black54, FontWeight.w700)
            ),
            DropdownButtonFormField<String>(
                value: selectGender,
                style: const TextStyle(color:Colors.purpleAccent),
                onChanged: (String? value){
                  setState(() {
                    selectGender = value!;
                  });
                },
                items: genderOptions.map<DropdownMenuItem<String>>((String value){
                  return DropdownMenuItem<String>(
                    value: value,
                      child: Text(value)
                       );
                }).toList() ,

                icon: const Icon(Icons.arrow_circle_down)

            ),

            const SizedBox(
              height: 20,
            ),
            ReusableText(
                text: 'Ngày sinh của bạn',
                style: appstyle(15, Colors.black54, FontWeight.w700)),
            CustomTextField(
                controller: birthday, hintText: " Ví dụ : 06/13/2005"),
            const SizedBox(
              height: 20,
            ),
            ReusableText(
                text: 'Bạn muốn đổi tên gọi của mình ?',
                style: appstyle(15, Colors.black54, FontWeight.w700)),
            CustomTextField(
                controller: username, hintText: " Ví dụ : văn vở"),
            const SizedBox(
              height: 30,
            ),
            Align(
              child: GestureDetector(
                onTap: () {
                  toConfirm();
                  if (isValid) {
                    Map<String, dynamic> updateData = {};
                    if (username.text.isNotEmpty) {
                      updateData['username'] = username.text;
                    }
                    if (phoneNumber.text.isNotEmpty) {
                      updateData['phone_number'] = phoneNumber.text;
                    }
                    if (address.text.isNotEmpty) {
                      updateData['address'] = address.text;
                    }
                    if (gender.text.isNotEmpty) {
                      updateData['gender'] = gender.text;
                    }
                    if (birthday.text.isNotEmpty) {
                      updateData['birthday'] = birthday.text;
                    }

                    UpProReq updatemodel = UpProReq.fromMap(updateData);

                    debugPrint('Ở UpdatePage address: ${address.text}');
                    usernotifier.UpdateProfile(updatemodel).then(
                          (response) {
                        if (response) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Cập nhật thông tin thành công')));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Cập nhật thất bại')));
                        }
                      },
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Vui lòng nhập thông tin!')));
                  }
                },
                child: Container(
                  height: 35,
                  width: 125,
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: Center(
                    child: ReusableText(
                      text: "Cập nhật ",
                      style: appstyle(18, Colors.white, FontWeight.bold),
                    ),
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
