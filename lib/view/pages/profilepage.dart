import 'package:flutter/material.dart';
import 'package:gohealth/constant/textstyles.dart';
import 'package:gohealth/data/model/user_profile.dart';
import 'package:gohealth/provider/authprovider.dart';
import 'package:gohealth/utils/contex_extension.dart';
import 'package:gohealth/view/components/atoms/photo_profile.dart';
import 'package:gohealth/view/components/organisms/edit_profile_view.dart';
import 'package:gohealth/view/components/organisms/history_bmi_view.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int currentIndex = 0;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        currentIndex = _tabController.index;
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
        leading: currentIndex == 1
            ? IconButton(
                icon: Icon(Icons.chevron_left_outlined),
                onPressed: () {
                  _tabController.animateTo(0);
                })
            : null,
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app_outlined),
              onPressed: () async {
                var result = await showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Confirmation"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("are you sure want to logout?"),
                          MaterialButton(
                            child: Text("Yes"),
                            onPressed: () {
                              context.pop(data: true);
                            },
                            color: Colors.red,
                          ),
                          MaterialButton(
                            onPressed: () {
                              context.pop(data: false);
                            },
                            child: Text("No"),
                            color: Colors.grey[100],
                          ),
                        ],
                      ),
                    );
                  },
                );
                if (result ?? false) {
                  context.authprovider().logout();
                }
              })
        ],
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Profile",
              style: TextStyles.title,
            ),
            Consumer<AuthProvider>(
              builder: (ctx, provider, _) => Text(
                "${(provider.userProfile ?? UserProfile()).name ?? ''}",
                style: TextStyles.subtitle,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 5),
                  child: Consumer<AuthProvider>(
                    builder: (ctx, prov, _) {
                      debugPrint("reloaded");
                      return PhotoProfileImage(
                        imageUrl: prov.profilePictUrl,
                        minradius: 20,
                        maxradius: 40,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                HistoryBmiView(
                  onclick: () {
                    _tabController.animateTo(1);
                  },
                ),
                EditProfileView()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
