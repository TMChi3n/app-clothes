import 'package:clothes_app/services/servicesForHome.dart';
import 'package:clothes_app/view/widgets/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:clothes_app/view/widgets/appstyle.dart';
import '../../models/auth/product/products.dart';

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
  void getproMale(){
    _male = Helper().getProductForMale();
  }
  void getproFemale(){
    _female = Helper().getProductForFemale();
  }

  void getproChil(){
    _chil = Helper().getProductForChildre();
  }
  @override
  void initState(){
    super.initState();
    getproMale();
    getproFemale();
    getproChil();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x0ffe2e2e),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(16, 5, 0, 0),
                height: MediaQuery.of(context).size.height * 0.17,
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 6.0),
                      child: CircleAvatar(
                        radius: 20,
                       backgroundImage: AssetImage("assets/images/user.png"),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        'Name',
                        style: TextStyle(fontSize: 26, color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 6.0),
                      child: Icon(Icons.settings, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top +
                    MediaQuery.of(context).size.height * 0.15,
              ),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.white,
                child: TabBar(
                  padding: EdgeInsets.zero,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: Colors.transparent,
                  controller: _tabController,
                  isScrollable: true,
                  labelColor: Colors.black,
                  labelStyle: appstyle(28, Colors.black, FontWeight.bold),
                  unselectedLabelColor: Colors.black.withOpacity(0.3),
                  tabs: const [
                    Tab(
                      text: 'Nam giới',
                    ),
                    Tab(
                      text: 'Nữ giới',
                    ),
                    Tab(text: 'Trẻ em')
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top +
                    MediaQuery.of(context).size.height * 0.21,
              ),
              child: Container(
                padding: const EdgeInsets.only(left: 12,top:10),
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

