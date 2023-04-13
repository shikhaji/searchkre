import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:search_kare/routs/app_routs.dart';
import 'package:search_kare/utils/app_asset.dart';
import 'package:search_kare/utils/app_color.dart';
import 'package:search_kare/utils/app_sizes.dart';
import 'package:search_kare/utils/app_text_style.dart';
import 'package:search_kare/utils/screen_utils.dart';
import 'package:search_kare/views/commonPopUp/delete_post_popup.dart';
import 'package:search_kare/widget/app_button.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Column(
        children: [
          _buildDrawerHeader(),
          Expanded(
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ScreenUtil().setVerticalSpacing(20),
                    _DrawerMenuListTile.asset(
                      title: 'Terms & Conditions',
                      onTap: () {
                        Navigator.pushNamed(context, Routs.termsAndCondition);
                      },
                      child: const Icon(Icons.local_police_outlined),
                    ),
                    _DrawerMenuListTile.asset(
                      title: 'Privacy Policy',
                      onTap: () {
                        Navigator.pushNamed(context, Routs.privacyPolicy);
                      },
                      child: const Icon(Icons.policy),
                    ),
                    _DrawerMenuListTile.asset(
                      title: 'About Us',
                      onTap: () {
                        Navigator.pushNamed(context, Routs.aboutUs);
                      },
                      child: const Icon(Icons.account_box),
                    ),
                    _DrawerMenuListTile.asset(
                      title: 'Contact Us',
                      onTap: () {
                          Navigator.pushNamed(context, Routs.contactUs);
                      },
                      child: const Icon(Icons.contact_phone_sharp),
                    ),
                    ScreenUtil().setVerticalSpacing(30),
                    SizedBox(
                      width: ScreenUtil().screenWidth - 200,
                      child: AppButton(
                        onPressed: () {
                          DeletePostPopUp.show(context, 'Logout',
                                  'Are you sure you want to logout?')
                              .then((value) async {
                            if (value == true) {
                              // Preferences.clearAllPref();
                              // Navigator.pushNamedAndRemoveUntil(
                              //     context, Routs.loginType, (route) => false);
                            }
                          });
                        },
                        title: 'Logout',
                      ),
                    ),
                    ScreenUtil().setVerticalSpacing(5),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return SizedBox(
      height: Sizes.s240.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // SvgPicture.asset(
          //   AppAsset.drawerBackground,
          //   fit: BoxFit.fill,
          // ),
          Container(
            color: AppColor.primaryColor,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.s20.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: Sizes.s80.h,
                      width: Sizes.s80.h,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image:
                              // getProfileData?.patientPhoto != ""
                              //     ? DecorationImage(
                              //         fit: BoxFit.cover,
                              //         image: NetworkImage(
                              //             "https://appointment.doctoroncalls.in/uploads/${getProfileData?.patientPhoto}" ??
                              //                 ""),
                              //       )
                              //     :
                              DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(AppAsset.dummyAvatar),
                          ))),
                  ScreenUtil().setVerticalSpacing(10),
                  Text(
                    "Hina Patel",
                    style: AppTextStyle.appText.copyWith(color: AppColor.white),
                  ),
                  const Text(
                    "hinaPatel@mailinator.com",
                    style: AppTextStyle.whiteSubtitle,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerMenuListTile extends StatelessWidget {
  final Widget child;
  final String title;
  final VoidCallback onTap;

  _DrawerMenuListTile.asset({
    required this.onTap,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: child,
      title: Text(
        title,
        style: AppTextStyle.label,
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.black,
      ),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }
}
