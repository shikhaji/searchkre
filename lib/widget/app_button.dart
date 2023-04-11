import 'package:flutter/material.dart';

import '../utils/app_color.dart';

import '../utils/app_text.dart';
import '../utils/app_text_style.dart';
import '../utils/screen_utils.dart';

class AppButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final double? height;
  final double? width;
  final Color? color;
  final bool? isStyle;
  const AppButton(
      {Key? key,
      required this.title,
      this.color,
      this.width,
      this.isStyle = false,
      required this.onPressed,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        height: height ?? ScreenUtil().setHeight(52),
        minWidth: width ?? double.infinity,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        color: color ?? AppColor.primaryColor,
        highlightColor: Colors.transparent,
        elevation: 0,
        onPressed: onPressed,
        child: appText(title,
            style: isStyle == false
                ? AppTextStyle.btnText
                : AppTextStyle.btnText.copyWith(color: AppColor.primaryColor)));
  }
}
