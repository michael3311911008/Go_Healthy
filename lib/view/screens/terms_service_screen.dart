import 'package:flutter/material.dart';
import 'package:gohealth/constant/color_pallete.dart';
import 'package:gohealth/constant/textstyles.dart';
import 'package:gohealth/view/components/atoms/primary_button.dart';
import 'package:gohealth/utils/contex_extension.dart';
import 'package:gohealth/view/screens/main_screen.dart';

class TermsServiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.thumb_up_outlined,
                size: 50,
                color: ColorPallete.primaryColor,
              ),
              Text(
                "Account Created !",
                style: TextStyles.title.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Your account has been created successfuly.\nPlease continue to start for using app.",
                style: TextStyles.subtitle,
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Container(
                      width: 150,
                      child: PrimaryButton(
                          text: "Continue",
                          onPressed: () {
                            context.authprovider().loadAuthDetails();
                            context.replaceAllTo(MainScreen());
                          }),
                    ),
                    Text.rich(
                      TextSpan(
                          style: TextStyles.subtitle,
                          children: [
                            TextSpan(
                              text: "Privacy Policy.",
                              style: TextStyles.subtitle.copyWith(
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            TextSpan(text: " and our "),
                            TextSpan(
                              text: "Terms and Conditions.",
                              style: TextStyles.subtitle.copyWith(
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                          text: "By clicking Continue, you agree to our "),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
