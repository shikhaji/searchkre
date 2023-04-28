import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_kare/api/url.dart';
import 'package:search_kare/models/all_company_post_job_model.dart';
import 'package:search_kare/routs/app_routs.dart';
import 'package:search_kare/routs/arguments.dart';
import 'package:search_kare/services/api_services.dart';
import 'package:search_kare/utils/app_color.dart';
import 'package:search_kare/utils/app_sizes.dart';
import 'package:search_kare/utils/app_text_style.dart';
import 'package:search_kare/utils/screen_utils.dart';
import 'package:search_kare/views/commonPopUp/delete_post_popup.dart';
import 'package:search_kare/widget/custom_sized_box.dart';
import 'package:search_kare/widget/drawer_widget.dart';
import 'package:search_kare/widget/scrollview.dart';

class CompanyHomeScreen extends StatefulWidget {
  const CompanyHomeScreen({Key? key}) : super(key: key);

  @override
  State<CompanyHomeScreen> createState() => _CompanyHomeScreenState();
}

class _CompanyHomeScreenState extends State<CompanyHomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  CompanyPostData? companyPostData;
  @override
  void initState() {
    _onGetPost();
    super.initState();
  }

  void _onGetPost() {
    ApiService().allCompanyPostJob().then((value) {
      if (value != null) {
        setState(() {
          companyPostData = value.message;
        });
      }
    });
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
            // SizedBoxH20(),
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Row(
            //     children: List.generate(10, (index) {
            //       return GestureDetector(
            //         onTap: () {},
            //         child: Container(
            //             margin: const EdgeInsets.all(Sizes.s8),
            //             padding: const EdgeInsets.only(
            //                 top: Sizes.s12,
            //                 bottom: Sizes.s12,
            //                 left: Sizes.s12,
            //                 right: Sizes.s12),
            //             decoration: BoxDecoration(
            //                 boxShadow: [
            //                   BoxShadow(
            //                     color: Colors.grey
            //                         .withOpacity(0.4), //color of shadow
            //                     spreadRadius: 2, //spread radius
            //                     blurRadius: 2, // blur radius
            //                     offset: const Offset(0, 2),
            //                   )
            //                 ],
            //                 color: AppColor.white,
            //                 borderRadius: BorderRadius.circular(Sizes.s12)),
            //             child: Text(
            //               "Marketing and research",
            //               style: AppTextStyle.appText.copyWith(
            //                 fontSize: Sizes.s16,
            //                 fontWeight: FontWeight.w600,
            //               ),
            //             )),
            //       );
            //     }),
            //   ),
            // ),
            SizedBoxH20(),
            companyPostData != null && companyPostData?.post != null
                ? Column(
                    children:
                        List.generate(companyPostData!.post.length, (index) {
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${companyPostData?.post[index].vapTitle}",
                                      style: AppTextStyle.appText
                                          .copyWith(fontSize: Sizes.s16),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () async {
                                        showDialogForMoreIcon(
                                            "${companyPostData?.post[index].vapId}");
                                      },
                                      icon: const Icon(
                                        Icons.more_vert_sharp,
                                        size: 24,
                                      ))
                                ],
                              ),
                            ),
                            SizedBoxH8(),
                            Image.network(
                              "${EndPoints.imageUrl}${companyPostData?.post[index].vapImage}",
                              width: double.infinity,
                            ),
                            SizedBoxH8(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "${companyPostData?.post[index].vapDesc}",
                                style: AppTextStyle.greySubTitle
                                    .copyWith(color: AppColor.black),
                              ),
                            ),
                            SizedBoxH8(),
                            const Divider(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, Routs.viewAllApplyCandidate,arguments: SendArguments(
                                        postId: companyPostData?.post[index].vapId
                                      ));
                                    },
                                    child: Text(
                                      "View Candidate",
                                      style: AppTextStyle.s20W7PrimaryColor
                                          .copyWith(
                                              fontSize: Sizes.s20,
                                              decoration:
                                                  TextDecoration.underline),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }),
                  )
                : Text("No Data Found!")
          ],
        ));
  }

  showDialogForMoreIcon(String postId) {
    showCupertinoModalPopup(
      context: context,
      builder: (a) => ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Material(
          child: Container(
            decoration: const BoxDecoration(
              color: AppColor.primaryColor,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(20),
                    color: AppColor.primaryColor,
                    child: Column(
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(context, Routs.editPost,
                                  arguments: SendArguments(
                                      bottomIndex: 1,
                                      editPost: true,
                                      postId: postId));
                            },
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.edit,
                                  color: AppColor.white,
                                ),
                                SizedBoxW8(),
                                Text("Edit Post",
                                    style: AppTextStyle.heading
                                        .copyWith(fontSize: Sizes.s20)),
                              ],
                            )),
                        SizedBoxH14(),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              DeletePostPopUp.show(context, 'Delete your post?',
                                      'Are you sure you want to delete the post.  You will not be able to recover it')
                                  .then((value) async {
                                if (value == true) {
                                  ApiService().deletePost(context, postId);
                                  _onGetPost();
                                }
                              });
                            },
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.delete,
                                  color: AppColor.white,
                                ),
                                SizedBoxW8(),
                                Text("Delete Post",
                                    style: AppTextStyle.heading
                                        .copyWith(fontSize: Sizes.s20)),
                              ],
                            )),
                      ],
                    )),
                const SizedBox(height: 10),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
