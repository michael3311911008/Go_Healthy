import 'package:gohealth/constant/color_pallete.dart';
import 'package:gohealth/utils/int_extension.dart';
import 'package:gohealth/utils/contex_extension.dart';
import 'package:flutter/material.dart';
import 'package:gohealth/view/components/atoms/logo_widgets.dart';
import 'package:gohealth/view/screens/main_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isAnimate = false;
  animate() {
    setState(() {
      isAnimate = true;
    });
  }

  @override
  void initState() {
    2500.delayMethod(animate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    var sized = (isAnimate) ? size.width * 4 : size.width / 1000;
    return SafeArea(
      child: Stack(children: [
        Positioned.fill(
            child: Container(
          color: ColorPallete.primaryColor,
        )),
        Align(
          alignment: Alignment.center,
          child: Center(
            child: SizedBox(
              width: size.width * 0.4,
              child: LogoWidget(),
            ),
          ),
        ),
        AnimatedPositioned(
            bottom: (isAnimate) ? -size.width : size.width * 0.5,
            left: (isAnimate) ? -size.width : size.width * 0.25,
            child: AnimatedContainer(
              height: sized,
              width: sized,
              duration: Duration(milliseconds: 350),
              curve: Curves.fastLinearToSlowEaseIn,
              onEnd: () => goToHome(),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(sized)),
            ),
            duration: Duration(milliseconds: 450),
            curve: Curves.bounceOut),
      ]),
    );
  }

  goToHome() {
    context.authprovider().loadAuthDetails();
    context.replaceTo(MainScreen());
  }
}
