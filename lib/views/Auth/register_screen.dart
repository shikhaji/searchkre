import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:search_kare/routs/app_routs.dart';
import 'package:search_kare/routs/arguments.dart';
import 'package:search_kare/services/api_services.dart';
import 'package:search_kare/utils/app_color.dart';
import 'package:search_kare/utils/app_sizes.dart';
import 'package:search_kare/utils/app_text.dart';
import 'package:search_kare/utils/app_text_style.dart';
import 'package:search_kare/utils/validation_mixin.dart';
import 'package:search_kare/widget/app_bars.dart';
import 'package:search_kare/widget/app_button.dart';
import 'package:search_kare/widget/app_text_field.dart';
import 'package:search_kare/widget/custom_sized_box.dart';
import 'package:search_kare/widget/scrollview.dart';

class RegisterScreen extends StatefulWidget {
  final SendArguments? arguments;
  const RegisterScreen({Key? key, this.arguments}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with ValidationMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _cPassword = TextEditingController();

  bool obscurePassword = true;
  bool obscureCPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(
        context,
        title: widget.arguments?.continueAs,
      ),
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: CustomScroll(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBoxH46(),
            SizedBoxH46(),
            appText("Register", style: AppTextStyle.s26W7Black),
            SizedBoxH6(),
            appText(
              "Fill your details to continue",
              style:
                  AppTextStyle.whiteSubtitle.copyWith(color: AppColor.darkGrey),
            ),
            SizedBoxH28(),
            AppTextField(
              title: "Name",
              controller: _name,
              hintText: "Enter your name",
              validator: nameValidator,
            ),
            AppTextField(
              title: "Mobile Number",
              controller: TextEditingController(
                  text: '+91 ${widget.arguments?.mobileNumber}'),
              hintText: "Enter mobile number",
              readOnly: true,
            ),
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
                title: "Register",
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    FormData data() {
                      return FormData.fromMap({
                        "name": _name.text.trim(),
                        'contact': widget.arguments?.mobileNumber,
                        "password": _password.text.trim(),
                        "type":
                            widget.arguments?.continueAs == "Candidate" ? 1 : 2
                      });
                    }

                    ApiService().register(context, data: data());
                  }
                }),
            SizedBoxH18(),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routs.login);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  appText(
                    "Already have an account? ",
                    style: AppTextStyle.appText.copyWith(fontSize: Sizes.s16),
                  ),
                  appText(
                    "Login",
                    style: AppTextStyle.s20W7PrimaryColor
                        .copyWith(color: AppColor.primaryLightColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
