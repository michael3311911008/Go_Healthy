import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohealth/constant/color_pallete.dart';
import 'package:gohealth/constant/textstyles.dart';

class TypeExercisePage extends StatelessWidget {
  const TypeExercisePage({
    Key? key,
    required this.onCLick,
  }) : super(key: key);
  final Function(bool isWithEquipment) onCLick;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[Text('please choose your part')] +
          (["with Equipment", "Without Equipment"]
              .map<Widget>(
                (e) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      onTap: () {
                        onCLick(e == "with Equipment");
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
