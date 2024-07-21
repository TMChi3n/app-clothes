import 'dart:convert';
import 'dart:typed_data';
import 'package:clothes_app/services/servicesForHome.dart';
import 'package:clothes_app/view/widgets/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:clothes_app/view/widgets/appstyle.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/product/products.dart';
import 'package:clothes_app/view/widgets/customtab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController =
  TabController(length: 3, vsync: this);
  late Future<List<Products>> _male;
  late Future<List<Products>> _female;
  late Future<List<Products>> _chil;
  String username = '';
  String avatarBase64 = '';
  Uint8List? avatar;
  void getproMale() {
    _male = Helper().getProductForMale();
  }

  void getproFemale() {
    _female = Helper().getProductForFemale();
  }

  void getproChil() {
    _chil = Helper().getProductForChildre();
  }

  @override
  void initState() {
    super.initState();
    getproMale();
    getproFemale();
    getproChil();
    _tabController.addListener(() {
      setState(() {});
    });
    _loadUserData();

  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? '';
      String? avatarBase64 = prefs.getString('avatar');
      if (avatarBase64 != null && avatarBase64.isNotEmpty) {
        // Kiểm tra và loại bỏ tiền tố 'data:image/jpeg;base64,'
        final regex = RegExp(r'data:image\/\w+;base64,');
        avatarBase64 = avatarBase64.replaceAll(regex, '');

        try {
          avatar = base64Decode(avatarBase64);
        } catch (e) {
          print('Error decoding avatarBase64: $e');
          avatar = null;
        }
      } else {
        avatar = null;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    debugPrint('<-----------Tại home_sreen người dùng đang sử dụng tên: $username--------->');
    return Scaffold(
      backgroundColor: const Color(0x00efeeee),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(16, 20, 0, 0),
                height: MediaQuery.of(context).size.height * 0.16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row( children: [
                    if (avatar != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: MemoryImage(avatar!),
                      ),
                    ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Text(
                            username,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black,fontStyle:FontStyle.normal,
                            fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Danh mục',
                      style: TextStyle(fontSize: 23, color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top +
                    MediaQuery.of(context).size.height * 0.13,
              ),
              child: Container(
                padding: const EdgeInsets.fromLTRB(1, 5, 10, 2),
                color: Colors.white,
                child: TabBar(
                  padding: EdgeInsets.zero,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: Colors.transparent,
                  controller: _tabController,
                  isScrollable: true,
                  labelColor: Colors.white,
                  labelStyle: appstyle(17, Colors.black, FontWeight.bold),
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    Tab(
                      child: CustomTab(
                        text: 'Nam giới',
                        isSelected: _tabController.index == 0,
                      ),
                    ),
                    Tab(
                      child: CustomTab(
                        text: 'Nữ giới',
                        isSelected: _tabController.index == 1,
                      ),
                    ),
                    Tab(
                      child: CustomTab(
                        text: 'Trẻ em',
                        isSelected: _tabController.index == 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top +
                    MediaQuery.of(context).size.height * 0.180,
              ),
              child: Container(
                padding: const EdgeInsets.only(left: 5),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    HomeWidget(male: _male),
                    HomeWidget(male: _female),
                    HomeWidget(male: _chil),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
