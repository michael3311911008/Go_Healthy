import 'package:flutter/material.dart';
import 'package:gohealth/data/model/response.dart';
import 'package:gohealth/data/model/user_profile.dart';
import 'package:gohealth/view/components/molecules/dialog_loading_progress.dart';
import 'package:gohealth/view/components/organisms/form_default.dart';
import 'package:gohealth/utils/contex_extension.dart';
import 'package:gohealth/view/screens/terms_service_screen.dart';

class Register extends StatelessWidget {
  static final GlobalKey gKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
            child: FormDefault(
              field: [
                "Name",
                "Gender",
                "Date Of Birth",
                "Height",
                "Weight",
                "Email",
                "Password"
              ],
              inputype: {
                "Height": TextInputType.number,
                "Weight": TextInputType.number,
                "Date Of Birth": TextInputType.datetime,
                "Email": TextInputType.emailAddress,
              },
              submitButtonLabel: "Sign Up Now",
              onSubmit: (Map<String, String> result,
                  GlobalKey<FormState> keyForm) async {
                Dialogs.showLoadingDialog(context, gKey);
                var profile = UserProfile(
                  dob: result['Date Of Birth'],
                  name: result['Name'],
                  gender: result['Gender'],
                  height: double.tryParse(result['Height'] ?? "0"),
                  weight: double.tryParse(result['Weight'] ?? "0"),
                );

                Response res = await context.authprovider().register(
                      result['Email']!,
                      result['Password']!,
                      profile,
                    );
                Dialogs.hideLoadingDialog(gKey);
                context.showSnackBar(res.message ?? "internal error");
                if (res.result) {
                  context.goTo(TermsServiceScreen());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
