import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_kare/routs/app_routs.dart';
import 'package:search_kare/routs/arguments.dart';
import 'package:search_kare/utils/app_color.dart';
import 'package:search_kare/utils/app_sizes.dart';
import 'package:search_kare/utils/app_text.dart';
import 'package:search_kare/utils/app_text_style.dart';
import 'package:search_kare/views/compnayDashboard/popUp/delete_post_popup.dart';
import 'package:search_kare/widget/custom_sized_box.dart';
import 'package:search_kare/widget/scrollview.dart';

class CompanyHomeScreen extends StatefulWidget {
  const CompanyHomeScreen({Key? key}) : super(key: key);

  @override
  State<CompanyHomeScreen> createState() => _CompanyHomeScreenState();
}

class _CompanyHomeScreenState extends State<CompanyHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Home",
            style: AppTextStyle.appText,
          ),
        ),
        body: CustomScroll(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBoxH46(),
            appText("Slider"),
            SizedBoxH20(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(10, (index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                        margin: const EdgeInsets.all(Sizes.s8),
                        padding: const EdgeInsets.only(
                            top: Sizes.s12,
                            bottom: Sizes.s12,
                            left: Sizes.s12,
                            right: Sizes.s12),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.4), //color of shadow
                                spreadRadius: 2, //spread radius
                                blurRadius: 2, // blur radius
                                offset: const Offset(0, 2),
                              )
                            ],
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(Sizes.s12)),
                        child: Text(
                          "Marketing and research",
                          style: AppTextStyle.appText.copyWith(
                            fontSize: Sizes.s16,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                  );
                }),
              ),
            ),
            SizedBoxH20(),
            ListView.builder(
                shrinkWrap: true,
                itemCount: 8,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: AppColor.textFieldColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Flutter Developer",
                                  style: AppTextStyle.appText
                                      .copyWith(fontSize: Sizes.s16),
                                ),
                              ),
                              IconButton(
                                  onPressed: () async {
                                    showDialogForMoreIcon();
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
                          "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg",
                          width: double.infinity,
                        ),
                        SizedBoxH8(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "A task topic is intended for a procedure that describes how to accomplish a task. A task topic lists a series of steps that users follow to produce an intended outcome. So a short description for a task topic should explain to the reader the purpose of the",
                            style: AppTextStyle.greySubTitle
                                .copyWith(color: AppColor.black),
                          ),
                        )
                      ],
                    ),
                  );
                })
          ],
        ));
  }

  showDialogForMoreIcon() {
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
                              Navigator.pushNamedAndRemoveUntil(context,
                                  Routs.mainCompanyHome, (route) => false,
                                  arguments: SendArguments(bottomIndex: 1));
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
                                  .then((value) async {});
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
