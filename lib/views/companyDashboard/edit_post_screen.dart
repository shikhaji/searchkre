import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';
import 'package:search_kare/api/url.dart';
import 'package:search_kare/helper/preferences.dart';
import 'package:search_kare/models/post_details_model.dart';
import 'package:search_kare/routs/arguments.dart';
import 'package:search_kare/services/api_services.dart';
import 'package:search_kare/utils/app_color.dart';
import 'package:search_kare/utils/app_sizes.dart';
import 'package:search_kare/utils/app_text_style.dart';
import 'package:search_kare/utils/screen_utils.dart';
import 'package:search_kare/utils/show_toast.dart';
import 'package:search_kare/utils/validation_mixin.dart';
import 'package:search_kare/widget/app_bars.dart';
import 'package:search_kare/widget/app_button.dart';
import 'package:search_kare/widget/app_text_field.dart';
import 'package:search_kare/widget/custom_sized_box.dart';
import 'package:search_kare/widget/drawer_widget.dart';
import 'package:search_kare/widget/scrollview.dart';

class EditPostScreen extends StatefulWidget {
  final SendArguments? arguments;
  const EditPostScreen({Key? key, this.arguments}) : super(key: key);

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> with ValidationMixin {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _des = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  XFile? selectedDocument;
  PostDetailsData? postDetailsData;
  var imageUrl;

  @override
  void initState() {
    print("hello post :=${widget.arguments?.editPost}");
    if (widget.arguments?.editPost == true) {
      ApiService().postDetails('${widget.arguments?.postId}').then((value) {
        if (value != null) {
          setState(() {
            postDetailsData = value.message;
            _title.text = postDetailsData!.post[0].vapTitle;
            _des.text = postDetailsData!.post[0].vapDesc;
            imageUrl = postDetailsData!.post[0].vapImage;
            print("{imageUrl:=${imageUrl}");
          });
        }
      });
    }
    super.initState();
  }

  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColor.textFieldColor,
        appBar: BackAppBar(
          context,
          title: 'Edit Post Job',
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
                  ),
                ),
                SizedBoxH28(),
                AppButton(
                    title: 'Edit Post',
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        var mediaFile;
                        if (selectedDocument != null) {
                          mediaFile = await MultipartFile.fromFile(
                              selectedDocument!.path);
                        } else {
                          mediaFile = postDetailsData?.post[0].vapImage;
                        }
                        FormData data() {
                          return FormData.fromMap({
                            "loginid": preferences.loginId,
                            'title': _title.text.trim(),
                            "desc": _des.text.trim(),
                            "media": mediaFile,
                            'postid': widget.arguments?.postId,
                          });
                        }

                        ApiService().updatePost(context, data: data());
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

  Widget uploadBox(String title) {
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
          child: selectedDocument != null && selectedDocument!.path != ''
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(File(selectedDocument!.path),
                      width: double.infinity, fit: BoxFit.cover))
              : ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    "${EndPoints.imageUrl}${imageUrl}",
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )),
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
