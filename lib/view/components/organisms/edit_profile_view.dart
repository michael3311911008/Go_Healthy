import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gohealth/constant/color_pallete.dart';
import 'package:gohealth/constant/textstyles.dart';
import 'package:gohealth/view/components/molecules/dialog_loading_progress.dart';
import 'package:gohealth/view/components/organisms/form_default.dart';
import 'package:gohealth/view/screens/home.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gohealth/utils/contex_extension.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MaterialButton(
            onPressed: () async {
              var _picker = ImagePicker();
              showBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              IconButton(
                                  icon: Icon(Icons.image_outlined),
                                  onPressed: () async {
                                    try {
                                      PickedFile? _image =
                                          await _picker.getImage(
                                              source: ImageSource.gallery);
                                      if (_image != null) {
                                        File image = File(_image.path);
                                        Dialogs.showLoadingDialog(
                                            context, Home.gKey);
                                        var result = await context
                                            .authprovider()
                                            .updatePhotoProfile(image);
                                        Dialogs.hideLoadingDialog(Home.gKey);
                                        context.showSnackBar(
                                            result.message ?? "internal error");
                                        await context
                                            .authprovider()
                                            .loadUserProfile();
                                      }
                                    } catch (e) {
                                      debugPrint(e.toString());
                                    }
                                    context.pop();
                                  }),
                              Text("Gallery"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              IconButton(
                                  icon: Icon(Icons.camera_alt_outlined),
                                  onPressed: () async {
                                    try {
                                      PickedFile? _image = await _picker
                                          .getImage(source: ImageSource.camera);
                                      if (_image != null) {
                                        File image = File(_image.path);
                                        Dialogs.showLoadingDialog(
                                            context, Home.gKey);
                                        var result = await context
                                            .authprovider()
                                            .updatePhotoProfile(image);
                                        Dialogs.hideLoadingDialog(Home.gKey);
                                        context.showSnackBar(
                                            result.message ?? "internal error");
                                        await context
                                            .authprovider()
                                            .loadUserProfile();
                                      }
                                    } catch (e) {
                                      debugPrint(e.toString());
                                    }
                                    context.pop();
                                  }),
                              Text("Camera"),
                            ],
                          ),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    );
                  },
                  backgroundColor: ColorPallete.primaryLight);
            },
            color: ColorPallete.primaryColor,
            child: Text(
              'Change Photo',
              style: TextStyles.title.copyWith(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FormDefault(
                submitButtonLabel: "Update Profile",
                field: ["Name", "Email", "Password", "Confirm Password"],
                validation: (value, currentFieldName, allfieldValue) {
                  if (currentFieldName!.toLowerCase().contains("password")) {
                    if (value != allfieldValue['Password'] ||
                        value != allfieldValue['Confirm Password']) {
                      return "password and confirm password not same";
                    }
                  }
                },
                onSubmit: (Map data, key) async {
                  Dialogs.showLoadingDialog(context, Home.gKey);
                  var result = await context.authprovider().updateProfile(
                      data['Email'], data['Password'], data['Name']);
                  Dialogs.hideLoadingDialog(Home.gKey);
                  context.showSnackBar(result.message ?? "internal error");
                  key.currentState!.reset();
                }),
          ),
        ],
      ),
    );
  }
}
