import 'package:flutter/material.dart';
import 'package:gohealth/constant/color_pallete.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Widget? icon;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry? padding;
  const PrimaryButton({
    Key? key,
    this.text = "",
    required this.onPressed,
    this.icon,
    this.padding,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: ColorPallete.primaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon ?? SizedBox(),
          Padding(
            padding: padding ?? const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: ColorPallete.primaryLight,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
