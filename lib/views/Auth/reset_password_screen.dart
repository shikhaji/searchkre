import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:search_kare/routs/arguments.dart';
import 'package:search_kare/services/api_services.dart';
import 'package:search_kare/utils/app_color.dart';
import 'package:search_kare/utils/app_text.dart';
import 'package:search_kare/utils/app_text_style.dart';
import 'package:search_kare/utils/validation_mixin.dart';
import 'package:search_kare/widget/app_bars.dart';
import 'package:search_kare/widget/app_button.dart';
import 'package:search_kare/widget/custom_sized_box.dart';
import 'package:search_kare/widget/app_text_field.dart';
import 'package:search_kare/widget/scrollview.dart';

class ResetPasswordScreen extends StatefulWidget {
  final SendArguments? arguments;
  const ResetPasswordScreen({Key? key, this.arguments}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen>
    with ValidationMixin {
  final TextEditingController _password = TextEditingController();
  final TextEditingController _cPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool obscurePassword = true;
  bool obscureCPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(
        context,
      ),
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: CustomScroll(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBoxH46(),
            SizedBoxH46(),
            appText("Reset Password", style: AppTextStyle.s26W7Black),
            SizedBoxH6(),
            appText(
              "Please set your password",
              style:
                  AppTextStyle.whiteSubtitle.copyWith(color: AppColor.darkGrey),
            ),
            SizedBoxH28(),
            AppTextField(
              controller: _password,
              hintText: "Enter Password",
              title: "Enter Password",
              validator: (value) {
                return confirmPasswordValidator(value!, _password.text.trim());
              },
              suffix: GestureDetector(
                  onTap: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                  child: obscurePassword
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility)),
              obscureText: obscurePassword,
            ),
            AppTextField(
              controller: _cPassword,
              hintText: "Enter Confirm Password",
              title: "Enter Confirm Password",
              validator: (value) {
                return confirmPasswordValidator(value!, _password.text.trim());
              },
              suffix: GestureDetector(
                  onTap: () {
                    setState(() {
                      obscureCPassword = !obscureCPassword;
                    });
                  },
                  child: obscureCPassword
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility)),
              obscureText: obscureCPassword,
            ),
            SizedBoxH8(),
            AppButton(
                title: "Reset",
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    FormData data() {
                      return FormData.fromMap({
                        "phone": widget.arguments?.mobileNumber,
                        "new_password": _cPassword.text.trim(),
                      });
                    }

                    ApiService().resetPassword(context, data: data());
                  }
                }),
            SizedBoxH18(),
          ],
        ),
      )),
    );
  }
}
