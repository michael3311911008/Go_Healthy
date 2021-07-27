import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohealth/constant/color_pallete.dart';
import 'package:gohealth/constant/textstyles.dart';
import 'package:gohealth/provider/mainprovider.dart';
import 'package:provider/provider.dart';

class HistoryBmiView extends StatelessWidget {
  final Function()? onclick;
  const HistoryBmiView({
    Key? key,
    this.onclick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
          onPressed: onclick,
          color: ColorPallete.primaryColor,
          child: Text(
            'Edit Profile',
            style: TextStyles.title.copyWith(),
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'History Your BMI',
                style: TextStyles.title
                    .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Icon(Icons.history_edu_outlined)
          ],
        ),
        Expanded(
          child: Consumer<MainProvider>(builder: (context, provider, _) {
            var historyBmi = provider.historyBmi;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: historyBmi.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                "BMI Score",
                                style: Get.textTheme.bodyText1!.copyWith(
                                    decoration: TextDecoration.underline),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                      "${historyBmi[index].bmi.toPrecision(2)}"),
                                ],
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "Last Date",
                                style: Get.textTheme.bodyText1!.copyWith(
                                    decoration: TextDecoration.underline),
                              ),
                              Text(historyBmi[index].date ?? "")
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            );
          }),
        ),
      ],
    );
  }
}
