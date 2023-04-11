import 'package:flutter/material.dart';
import 'package:search_kare/utils/app_color.dart';
import 'package:search_kare/utils/app_text_style.dart';
import 'package:search_kare/utils/validation_mixin.dart';
import 'package:search_kare/widget/app_text_field.dart';
import 'package:search_kare/widget/custom_sized_box.dart';
import 'package:search_kare/widget/scrollview.dart';

class PostJobScreen extends StatefulWidget {
  const PostJobScreen({Key? key}) : super(key: key);

  @override
  State<PostJobScreen> createState() => _PostJobScreenState();
}

class _PostJobScreenState extends State<PostJobScreen> with ValidationMixin {
  final TextEditingController _title = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.textFieldColor,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Post Job",
            style: AppTextStyle.appText,
          ),
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
              ],
            )));
  }
}
