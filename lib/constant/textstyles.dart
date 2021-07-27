import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class TextStyles {
  static final TextStyle title =
      Get.textTheme.headline5!.copyWith(fontSize: 25);
  static final TextStyle subtitle =
      Get.textTheme.bodyText2!.copyWith(fontSize: 14);
}
