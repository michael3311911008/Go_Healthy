import 'package:flutter/material.dart';
import 'package:gohealth/constant/textstyles.dart';
import 'package:gohealth/view/pages/difficulty_page.dart';
import 'package:gohealth/view/pages/list_exercise_page.dart';
import 'package:gohealth/view/pages/type_exercise_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  String _difficulty = '';
  bool _isWithEuipment = false;
  int _currentIndex = 0;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });
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
      appBar: AppBar(
        leading: _currentIndex != 0
            ? IconButton(
                iconSize: 30,
                icon: Icon(Icons.chevron_left_rounded),
                onPressed: () {
                  switch (_currentIndex) {
                    case 1:
                      setState(() {
                        _difficulty = '';
                      });
                      _tabController.animateTo(0);

                      break;
                    case 2:
                      setState(() {
                        _isWithEuipment = false;
                      });
                      _tabController.animateTo(1);

                      break;
                  }
                })
            : null,
        centerTitle: true,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Workout Videos",
              style: TextStyles.title,
            ),
            Text(
              "Workout At Home",
              style: TextStyles.subtitle,
            ),
          ],
        ),
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          DifficultiPage(
            onClick: (String value) {
              setState(() {
                _difficulty = value;
              });
              _tabController.animateTo(1);
            },
          ),
          TypeExercisePage(
            onCLick: (bool isWithEquipment) {
              setState(() {
                _isWithEuipment = isWithEquipment;
              });
              _tabController.animateTo(2);
            },
          ),
          ListExercisePage(
              difficulty: _difficulty, isWithEuipment: _isWithEuipment)
        ],
      ),
    );
  }
}
