import 'package:search_kare/utils/app_asset.dart';

class OnBoardingIntro {
  final String title;
  final String subTitle;
  final String imagePath;

  const OnBoardingIntro(
      {required this.title, required this.imagePath, required this.subTitle});
}

List<OnBoardingIntro> get listOfOnBoardingIntros {
  return [
    const OnBoardingIntro(
      title: 'Search job and apply \n job by own',
      subTitle:
          'Create a unique emotional stay that describe better then words',
      imagePath: AppAsset.onBoarding1,
    ),
    const OnBoardingIntro(
      title: 'Make your dream career \n with job',
      subTitle:
          'Create a unique emotional stay that describe better then words',
      imagePath: AppAsset.onBoarding2,
    ),
    const OnBoardingIntro(
      title: 'Make a interview process \n more easier',
      subTitle:
          'Create a unique emotional stay that describe better then words',
      imagePath: AppAsset.onBoarding3,
    ),
  ];
}
