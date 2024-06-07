import 'package:flutter/material.dart';
import 'package:clothes_app/view/widgets/appstyle.dart';


class ProfilePage extends StatefulWidget{
  const ProfilePage ({super.key});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Trang cá nhân',style: appstyle(40, Colors.black, FontWeight.bold),),
      ),
    );
  }

}