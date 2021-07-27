import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohealth/constant/textstyles.dart';
import 'package:gohealth/view/components/atoms/primary_button.dart';
import 'package:gohealth/view/components/molecules/dialog_loading_progress.dart';
import 'package:gohealth/view/components/organisms/form_default.dart';
import 'package:gohealth/utils/contex_extension.dart';
import 'package:gohealth/utils/int_extension.dart';
import 'package:gohealth/view/screens/register.dart';

class Login extends StatelessWidget {
  static final gKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              height: Get.size.height,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome",
                    style:
                        TextStyles.title.copyWith(fontWeight: FontWeight.bold),
                  ),
                  FormDefault(
                      submitButtonLabel: "   Login   ",
                      field: ["Email", "Password"],
                      widgetBeforeSubmitButton: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Lupa Password?',
                              style: TextStyles.subtitle.copyWith(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          )
                        ],
                      ),
                      onSubmit: (data, key) async {
                        Dialogs.showLoadingDialog(context, gKey);
                        var result = await context
                            .authprovider()
                            .login(data['Email']!, data['Password']!);
                        Dialogs.hideLoadingDialog(gKey);
                        if (result.result) {
                          context.showSnackBar(
                              result.message! + ", redirecting...");
                          2000.delayMethod(
                              () => context.authprovider().loadAuthDetails());
                        } else {
                          context
                              .showSnackBar(result.message ?? "internal error");
                        }
                      }),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("OR"),
                  ),
                  Container(
                    width: Get.size.width * 0.4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PrimaryButton(
                            text: "Register",
                            onPressed: () {
                              context.goTo(Register());
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
