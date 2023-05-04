import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';
import 'package:search_kare/api/url.dart';
import 'package:search_kare/helper/preferences.dart';
import 'package:search_kare/models/post_details_model.dart';
import 'package:search_kare/routs/app_routs.dart';
import 'package:search_kare/routs/arguments.dart';
import 'package:search_kare/services/api_services.dart';
import 'package:search_kare/utils/app_color.dart';
import 'package:search_kare/utils/app_sizes.dart';
import 'package:search_kare/utils/app_text_style.dart';
import 'package:search_kare/utils/screen_utils.dart';
import 'package:search_kare/utils/show_toast.dart';
import 'package:search_kare/utils/validation_mixin.dart';
import 'package:search_kare/widget/app_button.dart';
import 'package:search_kare/widget/app_text_field.dart';
import 'package:search_kare/widget/custom_sized_box.dart';
import 'package:search_kare/widget/drawer_widget.dart';
import 'package:search_kare/widget/scrollview.dart';

import 'company_home_screen.dart';
import 'main_company_screen.dart';

class PostJobScreen extends StatefulWidget {
  final SendArguments? arguments;
  const PostJobScreen({Key? key, this.arguments}) : super(key: key);

  @override
  State<PostJobScreen> createState() => _PostJobScreenState();
}

class _PostJobScreenState extends State<PostJobScreen> with ValidationMixin {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _des = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  XFile? selectedDocument;

  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColor.textFieldColor,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Post Job",
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
        body: Form(
            key: _formKey,
            child: CustomScroll(
              children: [
                SizedBoxH20(),
                AppTextField(
                  title: "Title",
                  controller: _title,
                  hintText: "Enter job title",
                  validator: titleValidation,
                  color: AppColor.white,
                ),
                AppTextField(
                  title: "Description",
                  controller: _des,
                  hintText: "Enter job Description",
                  validator: desValidation,
                  color: AppColor.white,
                ),
                InkWell(
                  onTap: () async {
                    showDialogForUserImage(1);
                  },
                  child: uploadBox(
                    'Upload Your Post',
                    selectedDocument != null ? selectedDocument!.path : '',
                  ),
                ),
                SizedBoxH28(),
                AppButton(
                    title: 'Post',
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        if (selectedDocument?.path == null) {
                          showToast("Upload your post image");
                        } else {
                          var mediaFile = await MultipartFile.fromFile(
                              selectedDocument!.path);
                          print("media File :=${selectedDocument!.path}");
                          print("media File :=${mediaFile}");
                          FormData data() {
                            return FormData.fromMap({
                              "loginid": preferences.loginId,
                              'title': _title.text.trim(),
                              "desc": _des.text.trim(),
                              "media": mediaFile,
                            });
                          }

                          ApiService().addJob(context, data: data());
                        }
                      }
                    })
              ],
            )));
  }

  showDialogForUserImage(int imgIndex) {
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
                  height: 50,
                  color: AppColor.primaryColor,
                  child: const Center(
                    child: Text(
                      "Select Image",
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColor.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(a).pop();
                        selectImage(ImageSource.gallery, 1);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.image_rounded,
                            color: AppColor.white,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Gallery",
                            style: AppTextStyle.greySubTitle
                                .copyWith(color: AppColor.white),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height / 12,
                      width: 3,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(a).pop();
                        selectImage(ImageSource.camera, 1);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.camera_alt_rounded,
                            color: AppColor.white,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Camera",
                            style: AppTextStyle.greySubTitle
                                .copyWith(color: AppColor.white),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget uploadBox(String title, String image) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColor.white,
        border: RDottedLineBorder.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      width: ScreenUtil().screenWidth,
      height: Sizes.s180.h,
      child: Center(
        child: image != ''
            ? ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.file(File(image),
                    width: double.infinity, fit: BoxFit.cover))
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.upload_file),
                  Text("Upload Your Post")
                ],
              ),
      ),
    );
  }

  selectImage(ImageSource source, int imgIndex) async {
    final ImagePicker imagePicker = ImagePicker();
    if (imgIndex == 1) {
      selectedDocument = await imagePicker.pickImage(source: source);
      setState(() {});
    }
  }
}
