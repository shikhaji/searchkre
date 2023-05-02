import 'package:flutter/material.dart';
import 'package:search_kare/models/candidate_apply_list_model.dart';
import 'package:search_kare/services/api_services.dart';
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

  CandidateApplyList? candidateApplyList;

  @override
  void initState() {
    ApiService().candidateApplyList().then((value) {
      if (value != null) {
        setState(() {
          candidateApplyList = value.message;
        });
      }
    });
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
        body: candidateApplyList != null && candidateApplyList?.job != null
            ? CustomScroll(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBoxH20(),
                  Column(
                    children:
                        List.generate(candidateApplyList!.job.length, (index) {
                      return Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 12),
                        margin: const EdgeInsets.only(bottom: 16),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColor.textFieldColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                "${candidateApplyList?.job[index].vapTitle}",
                                style: AppTextStyle.appText
                                    .copyWith(fontSize: Sizes.s16),
                              ),
                            ),
                            SizedBoxH8(),
                            SizedBoxH8(),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${candidateApplyList?.job[index].vapDesc}",
                                      style: AppTextStyle.greySubTitle
                                          .copyWith(color: AppColor.black),
                                    ),
                                    SizedBoxH8(),
                                    candidateApplyList?.job[index].cjalStatus == "0"? Text(
                                      "Application Pending",
                                      style: AppTextStyle.s20W7PrimaryColor
                                          .copyWith(
                                          fontSize: Sizes.s20,
                                          color: AppColor.orange
                                      ),
                                    ) :  candidateApplyList?.job[index].cjalStatus == "1"? Text(
                                      "Application Accepted",
                                      style: AppTextStyle.s20W7PrimaryColor
                                          .copyWith(
                                          fontSize: Sizes.s20,
                                          color: AppColor.green),
                                    ) : Text(
                                      "Application Reject",
                                      style: AppTextStyle.s20W7PrimaryColor
                                          .copyWith(
                                          fontSize: Sizes.s20,
                                          color: AppColor.red),
                                    ),
                                  ],
                                )),
                            SizedBoxH8(),
                          ],
                        ),
                      );
                    }),
                  )
                ],
              )
            : const Center(
                child: Text("Data Not Found"),
              ));
  }
}
