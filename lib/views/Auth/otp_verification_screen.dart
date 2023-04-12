import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:search_kare/models/auth_result.dart';
import 'package:search_kare/routs/arguments.dart';
import 'package:search_kare/utils/function.dart';
import 'package:search_kare/utils/loader.dart';
import 'package:search_kare/widget/app_bars.dart';
import 'package:search_kare/routs/app_routs.dart';
import 'package:search_kare/utils/app_color.dart';
import 'package:search_kare/utils/app_sizes.dart';
import 'package:search_kare/utils/app_text.dart';
import 'package:search_kare/utils/app_text_style.dart';
import 'package:search_kare/widget/app_button.dart';
import 'package:search_kare/widget/custom_sized_box.dart';
import 'package:search_kare/widget/scrollview.dart';

class OtpVerificationScreen extends StatefulWidget {
  final SendArguments? arguments;
  const OtpVerificationScreen({Key? key, this.arguments}) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpCode = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _canSubmit = false;

  int pinLength = 6;
  int _seconds = -1;
  Timer? _timer;
  String _verificationId = '';

  void _startTimer() {
    _seconds = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds--;
        if (_seconds == 0) {
          timer.cancel();
        }
      });
    });
  }

  Future<void> _otpVerify() async {
    if (_formKey.currentState?.validate() ?? false) {
      CommonFunctions.toast("otp verify successfully !!");
      if (widget.arguments?.otpStatus == 0) {
        Navigator.pushNamed(context, Routs.register,
            arguments: SendArguments(
                continueAs: widget.arguments?.continueAs,
                mobileNumber: widget.arguments?.mobileNumber));
      } else {
        Navigator.pushNamed(context, Routs.resetPassword);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await sendCode();
    });
  }

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
            appText("OTP Verification", style: AppTextStyle.s26W7Black),
            SizedBoxH6(),
            appText(
              "Enter 6 digit code sent to your phone number \n +91${widget.arguments?.mobileNumber}",
              style:
                  AppTextStyle.whiteSubtitle.copyWith(color: AppColor.darkGrey),
            ),
            SizedBoxH28(),
            _buildOtpTextField(),
            SizedBoxH8(),
            AppButton(
              color:
                  _canSubmit ? AppColor.primaryColor : const Color(0x66008080),
              title: "Verify OTP",
              onPressed: () {
                _canSubmit ? _verify(_otpCode.text) : null;
              },
            ),
            SizedBoxH18(),
            SizedBox(height: Sizes.s30.h),
            if (_timer?.isActive ?? false)
              Center(
                child: Text(
                  _seconds.toString(),
                  style: TextStyle(
                    fontSize: Sizes.s18.sp,
                  ),
                ),
              )
            else if (_seconds != -1)
              GestureDetector(
                  onTap: () async => sendCode(),
                  child: Center(
                    child: appText(
                      'Resend Code',
                      style: AppTextStyle.redTextStyle,
                    ),
                  )),
          ],
        ),
      )),
    );
  }

  Widget _buildOtpTextField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes.s12.w),
      child: PinCodeTextField(
        appContext: context,
        controller: _otpCode,
        length: 6,
        autoDismissKeyboard: true,
        autoDisposeControllers: true,
        backgroundColor: Colors.transparent,
        textStyle: AppTextStyle.s16W6Gray.copyWith(color: Colors.black),
        cursorColor: AppColor.black,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(12),
          borderWidth: 0.5,
          fieldHeight: Sizes.s55.h,
          fieldWidth: Sizes.s46.w,
          selectedFillColor: AppColor.textFieldColor,
          selectedColor: AppColor.textFieldColor,
          activeFillColor: AppColor.textFieldColor,
          inactiveFillColor: AppColor.textFieldColor,
          activeColor: Colors.black,
          inactiveColor: AppColor.primaryColor.withOpacity(0.2),
          fieldOuterPadding: EdgeInsets.zero,
        ),
        enableActiveFill: true,
        keyboardType: TextInputType.number,
        onCompleted: (value) {},
        onChanged: (value) {
          setState(() {
            if (value.length == 6) {
              _canSubmit = true;
            } else {
              _canSubmit = false;
            }
          });
        },
      ),
    );
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> sendCode() async {
    Loader.showLoader();
    await auth.setSettings(
      appVerificationDisabledForTesting: false,
      forceRecaptchaFlow: false,
    );
    auth.verifyPhoneNumber(
      phoneNumber: "${"+91"}${widget.arguments?.mobileNumber}",
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'web-context-cancelled') {
          throw e.message ?? 'Error';
        } else {
          throw e.message ?? 'Error';
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        Loader.hideLoader();
        _verificationId = verificationId;
        setState(() {});
        _startTimer();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
        setState(() {});
      },
    );
  }

  Future _verify(String smsCode) async {
    Loader.showLoader();
    try {
      final PhoneAuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: smsCode,
      );

      UserCredential credential =
          await FirebaseAuth.instance.signInWithCredential(authCredential);
      _otpVerify();

      Loader.hideLoader();
      return AuthResult(status: true, user: credential.user);
    } on FirebaseAuthException catch (e) {
      Loader.hideLoader();
      debugPrint('inside catch : ${e.message}');
      AuthResult result = AuthResult(status: false, message: e.message);

      switch (e.code) {
        case 'invalid-verification-code':
          result.message = 'Your SMS code is invalid.';
          break;
        case 'provider-already-linked':
          result.message = 'This phone number is already registered.';
          break;
        default:
      }
      if (result.message != null) {
        _otpCode.clear();
        CommonFunctions.toast(result.message!);
      }
      return AuthResult(status: false);
    }
  }
}
