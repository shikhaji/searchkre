import 'package:flutter/material.dart';
import 'package:search_kare/utils/app_asset.dart';
import 'package:search_kare/utils/app_color.dart';
import 'package:search_kare/utils/app_text_style.dart';
import 'package:search_kare/utils/screen_utils.dart';

class CandidateBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CandidateBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      onTap: onTap,
      showSelectedLabels: true,
      selectedLabelStyle:
          AppTextStyle.body1.copyWith(color: AppColor.primaryColor),
      unselectedLabelStyle: AppTextStyle.body1,
      showUnselectedLabels: true,
      items: [
        BottomNavigationBarItem(
          label: 'Home',
          icon: _buildImageIcon(AppAsset.home),
          activeIcon: _buildImageIcon(AppAsset.homeFill),
        ),
        BottomNavigationBarItem(
          label: 'Jobs',
          icon: _buildImageIcon(AppAsset.job),
          activeIcon: _buildImageIcon(AppAsset.jobFill),
        ),
        BottomNavigationBarItem(
          label: 'My Profile',
          icon: _buildImageIcon(AppAsset.profile),
          activeIcon: _buildImageIcon(AppAsset.profileFill),
        ),
      ],
    );
  }

  Widget _buildImageIcon(String imagePath, {double size = 22}) {
    return Image.asset(
      imagePath,
      height: ScreenUtil().setHeight(size),
      width: ScreenUtil().setHeight(size),
    );
  }
}
