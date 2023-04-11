import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:search_kare/models/ui/on_boarding_model.dart';
import 'package:search_kare/routs/app_routs.dart';
import 'package:search_kare/helper/preferences.dart';
import 'package:search_kare/utils/app_color.dart';
import 'package:search_kare/utils/app_sizes.dart';
import 'package:search_kare/utils/app_text_style.dart';
import 'package:search_kare/widget/app_bars.dart';
import 'package:search_kare/widget/custom_sized_box.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final ValueNotifier<int> _currentPageNotifier = ValueNotifier<int>(0);

  final List<OnBoardingIntro> _onBoardings = listOfOnBoardingIntros;

  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _currentPageNotifier,
      builder: (context, currentPage, _) {
        return Scaffold(
            appBar: BackAppBar(
              context,
              back: false,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routs.continueAs);
                  },
                  child: Text(
                    "Skip",
                    style: AppTextStyle.appText.copyWith(fontSize: Sizes.s16),
                  ),
                )
              ],
            ),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: AppColor.primaryColor,
              ),
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  _currentPageNotifier.value = index;
                },
                itemCount: _onBoardings.length,
                itemBuilder: (context, index) {
                  OnBoardingIntro onBoarding = _onBoardings[index];
                  return Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: Sizes.s100),
                        child: Image.asset(
                          onBoarding.imagePath,
                          height: Sizes.s300,
                        ),
                      ),
                      const Spacer(),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Sizes.s16, vertical: Sizes.s16),
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                              color: AppColor.primaryColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  onBoarding.title,
                                  style: AppTextStyle.title,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBoxH10(),
                                Text(
                                  onBoarding.subTitle,
                                  style: AppTextStyle.whiteSubtitle,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBoxH18(),
                                DotsIndicator(
                                  dotsCount: _onBoardings.length,
                                  position:
                                      _currentPageNotifier.value.toDouble(),
                                  decorator: DotsDecorator(
                                    activeColor: AppColor.white,
                                    color: AppColor.grey,
                                    activeShape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(Sizes.s8.h / 2),
                                    ),
                                    size: Size.square(Sizes.s8.h),
                                    activeSize: Size(Sizes.s34.h, Sizes.s8.h),
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {
                                      preferences.isIntroCompleted = true;
                                      if (currentPage <
                                          _onBoardings.length - 1) {
                                        _pageController.nextPage(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeIn,
                                        );
                                      } else {
                                        preferences.isIntroCompleted = true;
                                        Navigator.pushReplacementNamed(
                                          context,
                                          Routs.continueAs,
                                        );
                                      }
                                    },
                                    child: Text(
                                      currentPage < _onBoardings.length - 1
                                          ? 'Next'
                                          : 'Get Started',
                                      style: AppTextStyle.whiteSubtitle
                                          .copyWith(fontSize: Sizes.s16),
                                    ))
                              ],
                            ),
                          ))
                    ],
                  );
                },
              ),
            ));
      },
    );
  }
}
