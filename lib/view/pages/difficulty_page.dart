import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohealth/constant/color_pallete.dart';
import 'package:gohealth/constant/textstyles.dart';

class DifficultiPage extends StatelessWidget {
  const DifficultiPage({
    Key? key,
    required this.onClick,
  }) : super(key: key);
  final Function(String value) onClick;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[Text('please choose your part')] +
          (["Easy", "Medium", "Hard"]
              .map<Widget>(
                (e) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      onTap: () {
                        onClick(e);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorPallete.altGrey,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                            child: Text(
                          e,
                          style: TextStyles.subtitle.copyWith(
                            color: ColorPallete.primaryColor,
                            fontSize: 20,
                          ),
                        )),
                        height: 75,
                        width: Get.size.width * 0.75,
                      ),
                    ),
                  ),
                ),
              )
              .toList()),
    );
  }
}
