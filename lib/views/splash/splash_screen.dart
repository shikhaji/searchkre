import 'dart:async';
import 'package:flutter/material.dart';
import 'package:search_kare/helper/preferences.dart';
import 'package:search_kare/routs/app_routs.dart';
import 'package:search_kare/routs/arguments.dart';
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
    verify();
    // Timer(
    //     const Duration(seconds: 4),
    //     () => Navigator.pushNamedAndRemoveUntil(
    //         context, Routs.onBoarding, (route) => false));
  }

  Future<void> verify() async {
    Future.delayed(const Duration(seconds: 3)).then(
      (value) {
        if (preferences.isIntroCompleted == false) {
          Navigator.pushNamedAndRemoveUntil(
              context, Routs.onBoarding, (route) => false);
        } else {
          if (preferences.loginId != '') {
            if (preferences.loginType == "2") {
              Navigator.pushNamedAndRemoveUntil(
                  context, Routs.mainCandidateHome, (route) => false,
                  arguments: SendArguments(bottomIndex: 0));
            } else {
              Navigator.pushNamedAndRemoveUntil(
                  context, Routs.mainCompanyHome, (route) => false,
                  arguments: SendArguments(bottomIndex: 0));
            }
          } else {
            Navigator.pushNamedAndRemoveUntil(
                context, Routs.continueAs, (route) => false);
          }
        }
      },
    );
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
