import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gohealth/constant/color_pallete.dart';
import 'package:gohealth/constant/textstyles.dart';
import 'package:gohealth/provider/authprovider.dart';
import 'package:gohealth/provider/mainprovider.dart';
import 'package:provider/provider.dart';

extension ContextExtension on BuildContext {
  goTo(Widget to) {
    return Navigator.of(this).push(MaterialPageRoute(builder: (ctx) => to));
  }

  replaceAllTo(Widget to) {
    return Navigator.of(this).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => to), (route) => false);
  }

  pop({dynamic data}) {
    return Navigator.of(this).pop(data);
  }

  replaceTo(Widget to) {
    return Navigator.of(this)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => to));
  }

  showSnackBar(String msg) {
    ScaffoldMessenger.of(this).hideCurrentSnackBar();
    return ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Container(
          color: Colors.black54,
          child: Text(
            msg,
            style: TextStyles.subtitle.copyWith(
              color: ColorPallete.primaryLight,
            ),
          ),
        ),
      ),
    );
  }

  AuthProvider authprovider() {
    return Provider.of<AuthProvider>(this, listen: false);
  }

  MainProvider mainProvider() {
    return Provider.of<MainProvider>(this, listen: false);
  }
}
