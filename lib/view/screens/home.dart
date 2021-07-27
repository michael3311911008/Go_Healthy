import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohealth/constant/color_pallete.dart';
import 'package:gohealth/view/pages/bmipage.dart';
import 'package:gohealth/view/pages/homepage.dart';
import 'package:gohealth/view/pages/profilepage.dart';
import 'package:gohealth/utils/contex_extension.dart';

class Home extends StatefulWidget {
  static final gKey = GlobalKey();
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    context.mainProvider().loadAllData();
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: [
          HomePage(),
          BMIPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: Container(
        height: 100,
        decoration: BoxDecoration(
          color: ColorPallete.primaryColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(15),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TabBar(
              tabs: [
                Tab(
                  text: "Home",
                  icon: Icon(Icons.home),
                ),
                Tab(
                  text: "BMI",
                  icon: Icon(Icons.calculate_outlined),
                ),
                Tab(
                  text: "Profile",
                  icon: Icon(Icons.person_outline_rounded),
                ),
              ],
              controller: _tabController,
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                width: Get.size.width * 0.4,
                height: 8,
                decoration: BoxDecoration(
                  color: ColorPallete.backgroundDark,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            Container()
          ],
        ),
      ),
    );
  }
}
