import 'package:flutter/material.dart';
import 'package:search_kare/routs/app_routs.dart';
import 'package:search_kare/routs/arguments.dart';
import 'package:search_kare/utils/app_color.dart';
import 'package:search_kare/utils/app_sizes.dart';
import 'package:search_kare/utils/app_text_style.dart';
import 'package:search_kare/widget/custom_sized_box.dart';
import 'package:search_kare/widget/primary_padding.dart';

class ContinueAsScreen extends StatefulWidget {
  const ContinueAsScreen({Key? key}) : super(key: key);

  @override
  State<ContinueAsScreen> createState() => _ContinueAsScreenState();
}

class _ContinueAsScreenState extends State<ContinueAsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColor.primaryColor,
                ),
                shape: BoxShape.circle,
              ),
              child: RichText(
                text: TextSpan(
                  text: 'J',
                  style: AppTextStyle.title
                      .copyWith(color: AppColor.black, fontSize: Sizes.s36),
                  children: [
                    TextSpan(
                        text: 'O',
                        style: AppTextStyle.title.copyWith(
                            color: AppColor.primaryColor, fontSize: Sizes.s55)),
                    TextSpan(
                        text: 'B',
                        style: AppTextStyle.title.copyWith(
                            color: AppColor.black, fontSize: Sizes.s36)),
                  ],
                ),
              ),
            ),
          ),
        ),
        PrimaryPadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Continue as",
                style: AppTextStyle.title.copyWith(color: AppColor.black),
              ),
              SizedBoxH10(),
              containerBox(
                bgColor: AppColor.black,
                titleTextStyle:
                    AppTextStyle.title.copyWith(fontSize: Sizes.s20),
                subTitleTextStyle: AppTextStyle.whiteSubtitle,
                onPressed: () {
                  Navigator.pushNamed(context, Routs.mobileVerification,
                      arguments: SendArguments(continueAs: "Candidate"));
                },
                title: 'Candidate',
                btnColor: AppColor.white,
                subTitle: "Let`s recruit your grate candidate \nfaster here",
              ),
              SizedBoxH20(),
              containerBox(
                titleTextStyle: AppTextStyle.title
                    .copyWith(color: AppColor.black, fontSize: Sizes.s20),
                subTitleTextStyle:
                    AppTextStyle.whiteSubtitle.copyWith(color: AppColor.grey),
                bgColor: AppColor.textFieldColor,
                btnColor: AppColor.black,
                onPressed: () {
                  Navigator.pushNamed(context, Routs.mobileVerification,
                      arguments: SendArguments(continueAs: "Company"));
                },
                title: 'Company',
                subTitle: "Finding a job here never been  easier \nthen before",
              )
            ],
          ),
        ),
        SizedBoxH46(),
      ],
    ));
  }

  Widget containerBox(
      {required Color bgColor,
      required Color btnColor,
      required VoidCallback onPressed,
      required String title,
      required TextStyle titleTextStyle,
      required TextStyle subTitleTextStyle,
      required String subTitle}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: Sizes.s20, vertical: Sizes.s16),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: bgColor,
        ),
        child: Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: titleTextStyle,
                ),
                SizedBoxH10(),
                Text(
                  subTitle,
                  style: subTitleTextStyle,
                )
              ],
            )),
            Icon(
              Icons.arrow_circle_right_outlined,
              color: btnColor,
            ),
          ],
        ),
      ),
    );
  }
}
