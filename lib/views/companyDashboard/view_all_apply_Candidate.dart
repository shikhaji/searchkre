import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:search_kare/api/url.dart';
import 'package:search_kare/routs/app_routs.dart';
import 'package:search_kare/routs/arguments.dart';
import 'package:search_kare/services/api_services.dart';
import 'package:search_kare/utils/app_color.dart';
import 'package:search_kare/utils/app_sizes.dart';
import 'package:search_kare/utils/app_text_style.dart';
import 'package:search_kare/widget/custom_sized_box.dart';
import 'package:search_kare/widget/scrollview.dart';
import '../../models/get_apply_candidateList.dart';
import '../../utils/loader.dart';
import '../../widget/app_bars.dart';


class ViewAllApplyCandidate extends StatefulWidget {
  final SendArguments? arguments;
  const ViewAllApplyCandidate({Key? key, required this.arguments}) : super(key: key);

  @override
  State<ViewAllApplyCandidate> createState() => _ViewAllApplyCandidateState();
}

class _ViewAllApplyCandidateState extends State<ViewAllApplyCandidate> {

  CandidateList? companyPostData;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    _onGetCandidateList();
    super.initState();
    print('id---------------------${widget.arguments?.postId}');
  }
  void _onGetCandidateList() {
    ApiService().allApplyCandidateList('${widget.arguments?.postId}').then((value) {
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
        appBar: BackAppBar(
          context,
          title: 'All Candidate List',
        ),
        body: Form(
          key: _formKey,
          child: CustomScroll(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBoxH20(),
              companyPostData != null && companyPostData?.job != null
                  ?
              Column(
                children:
                List.generate(companyPostData!.job.length, (index) {
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
                              CircleAvatar(
                                radius: 25.0,
                                backgroundImage:NetworkImage("${EndPoints.imageUrl}${companyPostData!.job[index].branchPhoto}"),     backgroundColor: Colors.transparent,),
                              SizedBoxW10(),
                              Expanded(
                                child: Text(
                                  "${companyPostData!.job[index].branchName}",
                                  style: AppTextStyle.appText
                                      .copyWith(fontSize: Sizes.s16),
                                ),
                              ),
                              IconButton(
                                  onPressed: () async {
                                    showDialogForMoreIcon(
                                        "${companyPostData!.job[index].cjalLoginId}");
                                  },
                                  icon: const Icon(
                                    Icons.more_vert_sharp,
                                    size: 24,
                                  ))
                            ],
                          ),
                        ),
                        SizedBoxH8(),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(child: Text(
                                    "Phone No:",
                                    style: AppTextStyle.appText
                                        .copyWith(fontSize: Sizes.s14),
                                  ),),
                                  Expanded(child: Text(
                                    "${companyPostData!.job[index].branchContact}",
                                    style: AppTextStyle.appText
                                        .copyWith(fontSize: Sizes.s14),
                                  ),),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(child: Text(
                                    "Email Id:",
                                    style: AppTextStyle.appText
                                        .copyWith(fontSize: Sizes.s14),
                                  ),),
                                  Expanded(child: Text(
                                    "${companyPostData!.job[index].branchEmail}",
                                    style: AppTextStyle.appText
                                        .copyWith(fontSize: Sizes.s14),
                                  ),),
                                ],
                              ),
                              SizedBoxH10(),
                              SizedBoxH10(),
                              GestureDetector(
                                onTap: () {
                                  Loader.showLoader();
                                  pdfView(
                                      url:
                                      '${EndPoints.imageUrl}${companyPostData!.job[index].branchCv}',
                                      filename: companyPostData!.job[index].branchCv);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: AppColor.white),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "View CV",
                                        style: AppTextStyle.appText
                                            .copyWith(fontSize: Sizes.s14),
                                      ),
                                      SizedBoxW6(),
                                      const Icon(
                                        Icons.remove_red_eye,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBoxH8(),
                        const Divider(),
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 12),
                          child: companyPostData!.job[index].cjalStatus == "0" ? Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      FormData data() {
                                        return FormData.fromMap({
                                          "job_id": companyPostData!.job[index].cjalId.trim(),
                                          "status": "1",
                                        });
                                      }
                                      ApiService().updateJobStatus(context,data:data());
                                    }
                                  },
                                child: Text(
                                  "Accept",
                                  style: AppTextStyle.s20W7PrimaryColor
                                      .copyWith(
                                      fontSize: Sizes.s20,
                                      decoration:
                                      TextDecoration.underline),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    FormData data() {
                                      return FormData.fromMap({
                                        "job_id": companyPostData!.job[index].cjalId.trim(),
                                        "status": "2",
                                      });
                                    }
                                    ApiService().updateJobStatus(context,data:data());
                                  }
                                },
                                child: Text(
                                  "Reject",
                                  style: AppTextStyle.s20W7PrimaryColor
                                      .copyWith(
                                    color: AppColor.red,
                                      fontSize: Sizes.s20,
                                      decoration:
                                      TextDecoration.underline),
                                ),
                              )
                            ],
                          ) : companyPostData!.job[index].cjalStatus == "1"? Text(
                            "Application Accepted",
                            style: AppTextStyle.s20W7PrimaryColor
                                .copyWith(
                                fontSize: Sizes.s20),
                          ) : Text(
                            "Application Reject",
                            style: AppTextStyle.s20W7PrimaryColor
                                .copyWith(
                                fontSize: Sizes.s20,
                                color: AppColor.red),
                          ),
                        )
                      ],
                    ),
                  );
                }),
              )
                  : Text("No Data Found!")
            ],
          ),
        ));
  }

  Future pdfView({required String url, String? filename}) async {
    final file = await openFile(url, filename!);
    if (file == null) return;
    OpenFile.open(file.path);
    Loader.hideLoader();
  }

  Future<File?> openFile(String url, String name) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/$name');

    final response = await Dio().get(url,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            receiveTimeout: 0));

    final ref = file.openSync(mode: FileMode.write);
    ref.writeFromSync(response.data);
    await ref.close();
    return file;
  }

  showDialogForMoreIcon(String candidateId) {
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
                              Navigator.pushNamed(context, Routs.viewCandidateDetails,
                                  arguments: SendArguments(
                                      candidateId: candidateId));
                            },
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.remove_red_eye,
                                  color: AppColor.white,
                                ),
                                SizedBoxW8(),
                                Text("View Details",
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
