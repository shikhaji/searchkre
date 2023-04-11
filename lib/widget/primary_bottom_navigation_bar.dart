// import 'package:fin_doctor/utils/app_asset.dart';
// import 'package:fin_doctor/utils/app_color.dart';
// import 'package:fin_doctor/utils/app_text_style.dart';
// import 'package:fin_doctor/utils/screen_utils.dart';
// import 'package:flutter/material.dart';
//
// class PrimaryBottomNavigationBar extends StatelessWidget {
//   final int currentIndex;
//   final ValueChanged<int> onTap;
//
//   const PrimaryBottomNavigationBar({
//     Key? key,
//     required this.currentIndex,
//     required this.onTap,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       currentIndex: currentIndex,
//       backgroundColor: Colors.white,
//       type: BottomNavigationBarType.fixed,
//       onTap: onTap,
//       showSelectedLabels: true,
//       selectedLabelStyle:
//           AppTextStyle.body1.copyWith(color: AppColor.primaryColor),
//       unselectedLabelStyle: AppTextStyle.body1,
//       showUnselectedLabels: true,
//       items: [
//         BottomNavigationBarItem(
//           label: 'Home',
//           icon: _buildImageIcon(AppAsset.homeFill),
//           activeIcon: _buildImageIcon(AppAsset.home),
//         ),
//         BottomNavigationBarItem(
//           label: 'My Order',
//           icon: _buildImageIcon(AppAsset.order),
//           activeIcon: _buildImageIcon(AppAsset.orderFill),
//         ),
//         BottomNavigationBarItem(
//           label: 'Services',
//           icon: _buildImageIcon(AppAsset.service),
//           activeIcon: _buildImageIcon(AppAsset.serviceFill),
//         ),
//         BottomNavigationBarItem(
//           label: 'My Profile',
//           icon: _buildImageIcon(AppAsset.profile),
//           activeIcon: _buildImageIcon(AppAsset.profileFill),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildImageIcon(String imagePath, {double size = 22}) {
//     return Image.asset(
//       imagePath,
//       height: ScreenUtil().setHeight(size),
//       width: ScreenUtil().setHeight(size),
//     );
//   }
// }
