import 'dart:async';
import 'package:flutter/material.dart';
import 'package:search_kare/routs/app_routs.dart';
import 'package:search_kare/utils/app_color.dart';
import 'package:search_kare/utils/app_text.dart';
import 'package:search_kare/utils/app_text_style.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 4),
        () => Navigator.pushNamedAndRemoveUntil(
            context, Routs.onBoarding, (route) => false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: AppColor.black,
      child: Center(
          child: appText(
        "SEARCH KARE",
        style: AppTextStyle.heading.copyWith(letterSpacing: 9),
      )),
    ));
  }
}
