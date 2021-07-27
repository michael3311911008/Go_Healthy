import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gohealth/constant/color_pallete.dart';
import 'package:gohealth/constant/textstyles.dart';
import 'package:gohealth/provider/mainprovider.dart';
import 'package:gohealth/utils/contex_extension.dart';
import 'package:gohealth/view/screens/video_screen.dart';
import 'package:provider/provider.dart';

class ListExercisePage extends StatelessWidget {
  const ListExercisePage({
    Key? key,
    required String difficulty,
    required bool isWithEuipment,
  })   : _difficulty = difficulty,
        _isWithEuipment = isWithEuipment,
        super(key: key);

  final String _difficulty;
  final bool _isWithEuipment;

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(builder: (ctx, provider, _) {
      var itemList = provider.exercises
          .where((element) =>
              element.difficulty!.toLowerCase() == _difficulty.toLowerCase() &&
              element.type! == (_isWithEuipment ? 1 : 0))
          .toList();
      return ListView.builder(
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                itemList[index].title ?? "",
                style: TextStyles.title,
              ),
              Container(
                width: Get.size.width * 0.75,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(itemList[index].thumbnail),
                  ),
                ),
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      context.goTo(VideoScreen(itemList[index]));
                    },
                    icon: Icon(Icons.play_circle_outline),
                    color: ColorPallete.primaryLight,
                    iconSize: 60,
                  ),
                ),
              ),
            ],
          );
        },
      );
    });
  }
}
