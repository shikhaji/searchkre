import 'package:flutter/material.dart';
import 'package:search_kare/routs/app_routs.dart';
import 'package:search_kare/routs/arguments.dart';
import 'package:search_kare/services/api_services.dart';
import 'package:search_kare/utils/app_color.dart';
import 'package:search_kare/utils/app_sizes.dart';
import 'package:search_kare/utils/app_text.dart';
import 'package:search_kare/utils/app_text_style.dart';
import 'package:search_kare/utils/show_toast.dart';
import 'package:search_kare/utils/validation_mixin.dart';
import 'package:search_kare/widget/app_bars.dart';
import 'package:search_kare/widget/app_button.dart';
import 'package:search_kare/widget/custom_sized_box.dart';
import 'package:search_kare/widget/app_text_field.dart';
import 'package:search_kare/widget/scrollview.dart';

class MobileVerificationScreen extends StatefulWidget {
  final SendArguments? arguments;
  const MobileVerificationScreen({Key? key, this.arguments}) : super(key: key);

  @override
  State<MobileVerificationScreen> createState() =>
      _MobileVerificationScreenState();
}

class _MobileVerificationScreenState extends State<MobileVerificationScreen>
    with ValidationMixin {
  final TextEditingController _mNumber = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
            appText("Mobile Verification", style: AppTextStyle.s26W7Black),
            SizedBoxH6(),
            appText(
              "Please verify your mobile number first",
              style:
                  AppTextStyle.whiteSubtitle.copyWith(color: AppColor.darkGrey),
            ),
            SizedBoxH28(),
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
            SizedBoxH8(),
            AppButton(
                title: "Send OTP",
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    ApiService()
                        .mobileVerify(context,
                            arguments: SendArguments(
                              mobileNumber: _mNumber.text.trim(),
                              continueAs: widget.arguments?.continueAs,
                            ))
                        .then((value) {
                      if (value.data['message'] == 0) {
                        Navigator.pushNamed(context, Routs.otpVerification,
                            arguments: SendArguments(
                              mobileNumber: _mNumber.text.trim(),
                              continueAs: widget.arguments?.continueAs,
                              otpStatus: 0,
                            ));
                      } else {
                        showToast(
                            'Your number is already register please login');
                      }
                    });
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
