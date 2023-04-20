import 'package:flutter/material.dart';
import 'package:search_kare/utils/app_color.dart';
import 'package:search_kare/utils/app_sizes.dart';
import 'package:search_kare/utils/app_text_style.dart';
import 'package:search_kare/utils/screen_utils.dart';
import 'package:search_kare/widget/custom_sized_box.dart';
import 'package:search_kare/widget/drawer_widget.dart';
import 'package:search_kare/widget/scrollview.dart';

class ApplyJobListScreen extends StatefulWidget {
  const ApplyJobListScreen({Key? key}) : super(key: key);

  @override
  State<ApplyJobListScreen> createState() => _ApplyJobListScreenState();
}

class _ApplyJobListScreenState extends State<ApplyJobListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Home",
            style: AppTextStyle.appText,
          ),
          leading: IconButton(
              onPressed: () {
                openDrawer();
              },
              icon: const Icon(Icons.menu_open_sharp)),
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          elevation: 0,
          width: ScreenUtil().screenWidth * 0.8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(Sizes.s20.r),
              bottomRight: Radius.circular(Sizes.s20.r),
            ),
          ),
          child: const DrawerWidget(),
        ),
        body: CustomScroll(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBoxH20(),
            ListView.builder(
                shrinkWrap: true,
                itemCount: 8,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 12),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: AppColor.textFieldColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            "Flutter Developer",
                            style: AppTextStyle.appText
                                .copyWith(fontSize: Sizes.s16),
                          ),
                        ),
                        SizedBoxH8(),
                        SizedBoxH8(),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "A task topic is intended for a procedure that describes how to accomplish a task. A task topic lists a series of steps that users follow to produce an intended outcome. So a short description for a task topic should explain to the reader the purpose of the",
                                  style: AppTextStyle.greySubTitle
                                      .copyWith(color: AppColor.black),
                                ),
                                SizedBoxH8(),
                                Text(
                                  "Your job is pending",
                                  style: AppTextStyle.appText.copyWith(
                                      fontSize: Sizes.s16, color: Colors.red),
                                ),
                              ],
                            )),
                        SizedBoxH8(),
                      ],
                    ),
                  );
                })
          ],
        ));
  }
}
