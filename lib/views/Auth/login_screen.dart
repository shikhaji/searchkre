import 'package:flutter/material.dart';
import 'package:search_kare/routs/app_routs.dart';
import 'package:search_kare/routs/arguments.dart';
import 'package:search_kare/utils/app_color.dart';
import 'package:search_kare/utils/app_sizes.dart';
import 'package:search_kare/utils/app_text.dart';
import 'package:search_kare/utils/app_text_style.dart';
import 'package:search_kare/utils/validation_mixin.dart';
import 'package:search_kare/widget/app_button.dart';
import 'package:search_kare/widget/custom_sized_box.dart';
import 'package:search_kare/widget/app_text_field.dart';
import 'package:search_kare/widget/scrollview.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ValidationMixin {
  final TextEditingController _mNumber = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: CustomScroll(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBoxH46(),
            appText("Hi There! 👋",
                style: AppTextStyle.s26W7Black.copyWith(
                    fontSize: Sizes.s28, color: AppColor.primaryColor)),
            appText(
              "Welcome back, Please login with phone number and password",
              style:
                  AppTextStyle.whiteSubtitle.copyWith(color: AppColor.darkGrey),
            ),
            SizedBoxH46(),
            AppTextField(
              title: "Mobile Number",
              controller: _mNumber,
              hintText: "Enter mobile number",
              keyboardInputType: TextInputType.phone,
              validator: mobileNumberValidator,
              textInputAction: TextInputAction.done,
              prefix: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Text(
                  "+91",
                  style: AppTextStyle.s16W6Gray.copyWith(color: Colors.black),
                ),
              ),
            ),
            AppTextField(
              controller: _password,
              hintText: "Enter Password",
              title: "Enter Password",
              validator: passwordValidator,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routs.forgotPassword);
                    },
                    child:
                        appText("Forgot password?", style: AppTextStyle.label))
              ],
            ),
            SizedBoxH8(),
            AppButton(
                title: "Login",
                onPressed: () {
                  // if (_formKey.currentState?.validate() ?? false) {}
                  // Navigator.pushNamed(context, Routs.updateCandidate,
                  //     arguments:
                  //         SendArguments(mobileNumber: _mNumber.text.trim()));
                  // Navigator.pushNamed(context, Routs.updateCompany,
                  //     arguments:
                  //         SendArguments(mobileNumber: _mNumber.text.trim()));
                  // Navigator.pushNamedAndRemoveUntil(
                  //     context, Routs.mainCandidateHome, (route) => false,
                  //     arguments: SendArguments(bottomIndex: 0));
                  Navigator.pushNamedAndRemoveUntil(
                      context, Routs.mainCompanyHome, (route) => false,
                      arguments: SendArguments(bottomIndex: 0));
                }),
            SizedBoxH18(),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routs.continueAs);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  appText(
                    "You don’t have an account? ",
                    style: AppTextStyle.appText.copyWith(fontSize: Sizes.s16),
                  ),
                  appText(
                    "Register",
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
