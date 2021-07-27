import 'package:flutter/material.dart';
import 'package:gohealth/provider/authprovider.dart';
import 'package:gohealth/view/screens/Home.dart';
import 'package:gohealth/view/screens/login.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, provider, _) => Container(
        child: provider.isLogin ? Home() : Login(),
      ),
    );
  }
}
