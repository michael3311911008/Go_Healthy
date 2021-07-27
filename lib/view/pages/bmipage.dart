import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohealth/constant/color_pallete.dart';
import 'package:gohealth/constant/textstyles.dart';
import 'package:gohealth/provider/mainprovider.dart';
import 'package:gohealth/view/components/organisms/form_default.dart';
import 'package:provider/provider.dart';
import 'package:gohealth/utils/contex_extension.dart';

class BMIPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Body Mass Index",
              style: TextStyles.title,
            ),
            Text(
              "Create Your Dream Body",
              style: TextStyles.subtitle,
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(child: Container(color: ColorPallete.primaryLight)),
          Align(
            alignment: Alignment.center,
            child: Consumer<MainProvider>(builder: (context, provider, _) {
              if (provider.historyBmi.length < 1) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: Text(
                            "You don\'t have any history of BMI, click button below to update your BMI ",
                            style: TextStyles.title,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'BMI Score : ${provider.historyBmi.first.bmi.toPrecision(2)}',
                    style:
                        TextStyles.title.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'you are classified as ${provider.historyBmi.first.className}',
                    style: TextStyles.subtitle,
                  ),
                ],
              );
            }),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 50),
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  onTap: () async {
                    showDialog(
                        context: context,
                        builder: (ctx) {
                          return Material(
                            child: Container(
                              width: Get.size.width * 0.8,
                              height: 200,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            icon: Icon(Icons.close),
                                            onPressed: () => context.pop())
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 20,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Update Your Bmi ",
                                          style: TextStyles.title,
                                        ),
                                        FormDefault(
                                            field: [
                                              "height",
                                              "weight"
                                            ],
                                            inputype: {
                                              "height": TextInputType.number,
                                              "weight": TextInputType.number,
                                            },
                                            onSubmit: (data, key) async {
                                              await context
                                                  .mainProvider()
                                                  .updateBmi(
                                                    double.tryParse(
                                                        data["height"] ?? "0"),
                                                    double.tryParse(
                                                        data["weight"] ?? "0"),
                                                  );
                                              context
                                                  .mainProvider()
                                                  .loadHistoryBmi();
                                              context.pop();
                                            }),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: Container(
                    width: Get.size.width * 0.6,
                    height: 40,
                    decoration: BoxDecoration(
                      color: ColorPallete.primaryColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Text(
                        "update your bmi",
                        style: TextStyle(color: ColorPallete.primaryLight),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
