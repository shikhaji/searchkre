import 'package:flutter/material.dart';
import 'app_color.dart';
import 'app_sizes.dart';

class AppTextStyle {
  AppTextStyle._();

  static const TextStyle heading = TextStyle(
      fontSize: Sizes.s26, fontWeight: FontWeight.w900, color: AppColor.white);

  static const TextStyle btnText = TextStyle(
      fontSize: Sizes.s20, fontWeight: FontWeight.w600, color: AppColor.white);

  static const TextStyle title = TextStyle(
      fontSize: Sizes.s24, fontWeight: FontWeight.w700, color: AppColor.white);
  static const TextStyle label = TextStyle(
      fontSize: Sizes.s16, fontWeight: FontWeight.w500, color: AppColor.black);
  static const TextStyle redTextStyle = TextStyle(
    fontSize: Sizes.s16,
    fontWeight: FontWeight.bold,
    color: AppColor.orange,
  );
  static const TextStyle body1 =
  TextStyle(fontSize: Sizes.s12, fontWeight: FontWeight.w900);
  static const TextStyle greySubTitle = TextStyle(
      color: AppColor.grey, fontSize: Sizes.s16, fontWeight: FontWeight.w400);
  static const TextStyle whiteSubtitle = TextStyle(
      fontSize: Sizes.s14,
      fontWeight: FontWeight.w500,
      color: AppColor.lightWhite);

  static const TextStyle bottomText = TextStyle(
    fontSize: Sizes.s18,
    fontWeight: FontWeight.w700,
    color: AppColor.primaryColor,
  );
  static const TextStyle appText = TextStyle(
    fontSize: Sizes.s20,
    fontWeight: FontWeight.w700,
    color: AppColor.black,
  );

  static const TextStyle s26W7Black = TextStyle(
      fontSize: Sizes.s26, fontWeight: FontWeight.w700, color: AppColor.black);
  static const TextStyle s20W7PrimaryColor = TextStyle(
      fontSize: Sizes.s20,
      fontWeight: FontWeight.w700,
      color: AppColor.primaryColor);
  static const TextStyle s16W6Gray = TextStyle(
      fontSize: Sizes.s16, fontWeight: FontWeight.w600, color: AppColor.grey);

  static TextStyle s14W4HintText = const TextStyle(
      fontSize: Sizes.s14,
      color: AppColor.hintText,
      fontWeight: FontWeight.w400);

  static const TextStyle s16W5Red = TextStyle(
      fontSize: Sizes.s16, fontWeight: FontWeight.w500, color: AppColor.red);
}
