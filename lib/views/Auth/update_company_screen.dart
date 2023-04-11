import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:search_kare/routs/arguments.dart';
import 'package:search_kare/utils/app_asset.dart';
import 'package:search_kare/utils/app_color.dart';
import 'package:search_kare/utils/app_sizes.dart';
import 'package:search_kare/utils/app_text.dart';
import 'package:search_kare/utils/app_text_style.dart';
import 'package:search_kare/utils/file_utils.dart';
import 'package:search_kare/utils/screen_utils.dart';
import 'package:search_kare/utils/validation_mixin.dart';
import 'package:search_kare/widget/app_bars.dart';
import 'package:search_kare/widget/app_button.dart';
import 'package:search_kare/widget/custom_sized_box.dart';
import 'package:search_kare/widget/app_text_field.dart';
import 'package:search_kare/widget/scrollview.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';

class UpdateCompanyScreen extends StatefulWidget {
  final SendArguments? arguments;
  const UpdateCompanyScreen({Key? key, this.arguments}) : super(key: key);

  @override
  State<UpdateCompanyScreen> createState() => _UpdateCompanyScreenState();
}

class _UpdateCompanyScreenState extends State<UpdateCompanyScreen>
    with ValidationMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _bName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _zipCode = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _qualification = TextEditingController();
  final TextEditingController _businessType = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(
        context,
        title: "Candidate",
      ),
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: CustomScroll(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBoxH46(),
            appText("Update Profile", style: AppTextStyle.s26W7Black),
            SizedBoxH6(),
            appText(
              "Please update your profile and continue",
              style:
                  AppTextStyle.whiteSubtitle.copyWith(color: AppColor.darkGrey),
            ),
            SizedBoxH28(),
            appText("Personal Details", style: AppTextStyle.appText),
            SizedBoxH14(),
            AppTextField(
              title: "Business Name",
              controller: _bName,
              hintText: "Enter your business name",
              validator: businessNameValidator,
            ),
            AppTextField(
              title: "Your Name",
              controller: _name,
              hintText: "Enter your name",
              validator: nameValidator,
            ),
            AppTextField(
              title: "Email ID",
              controller: _email,
              hintText: "Enter your email-id",
              validator: emailValidator,
            ),
            AppTextField(
              title: "Mobile Number",
              controller: TextEditingController(
                  text: "+91 ${widget.arguments?.mobileNumber}"),
              hintText: "Enter mobile number",
              keyboardInputType: TextInputType.phone,
            ),
            SizedBoxH14(),
            appText("Location", style: AppTextStyle.appText),
            SizedBoxH14(),
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    title: "State",
                    controller: _state,
                    hintText: "Enter your state",
                    validator: stateValidation,
                  ),
                ),
                SizedBoxW8(),
                Expanded(
                  child: AppTextField(
                    title: "City",
                    controller: _city,
                    hintText: "Enter your city",
                    validator: cityValidation,
                  ),
                ),
              ],
            ),
            AppTextField(
              title: "Zipcode",
              controller: _zipCode,
              hintText: "Enter your zipCode",
              validator: zipCodeValidation,
            ),
            AppTextField(
              title: "Address",
              controller: _address,
              hintText: "Enter your address",
              validator: addressValidation,
            ),
            SizedBoxH14(),
            appText("Business", style: AppTextStyle.appText),
            SizedBoxH14(),
            AppTextField(
              title: "Business Type",
              controller: _businessType,
              hintText: "Enter your business type",
              validator: businessTypeValidation,
            ),
            SizedBoxH28(),
            AppButton(
                title: "Update",
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {}
                }),
            SizedBoxH28(),
          ],
        ),
      )),
    );
  }
}
