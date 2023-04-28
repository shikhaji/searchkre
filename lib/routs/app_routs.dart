import 'package:flutter/material.dart';
import 'package:search_kare/views/Auth/continue_as_screen.dart';
import 'package:search_kare/views/Auth/forgot_password_screen.dart';
import 'package:search_kare/views/Auth/login_screen.dart';
import 'package:search_kare/views/Auth/mobile_verification_screen.dart';
import 'package:search_kare/views/Auth/otp_verification_screen.dart';
import 'package:search_kare/views/Auth/register_screen.dart';
import 'package:search_kare/views/Auth/reset_password_screen.dart';
import 'package:search_kare/views/Auth/update_candidate_screen.dart';
import 'package:search_kare/views/Auth/update_company_screen.dart';
import 'package:search_kare/views/candidateDashboard/main_candidate_screen.dart';
import 'package:search_kare/views/companyDashboard/edit_post_screen.dart';
import 'package:search_kare/views/companyDashboard/main_company_screen.dart';
import 'package:search_kare/views/companyDashboard/post_job_screen.dart';
import 'package:search_kare/views/companyDashboard/view_candidate_details.dart';
import 'package:search_kare/views/onBoarding/on_boarding_screen.dart';
import 'package:search_kare/views/sideMenu/about_us.dart';
import 'package:search_kare/views/sideMenu/contact_us.dart';
import 'package:search_kare/views/sideMenu/faq_screen.dart';
import 'package:search_kare/views/sideMenu/privacy_policy.dart';
import 'package:search_kare/views/sideMenu/terms_and_condition_screen.dart';
import 'package:search_kare/views/splash/splash_screen.dart';
import '../views/companyDashboard/view_all_apply_Candidate.dart';
import 'arguments.dart';

class Routs {
  static const String splash = "/splash_screen";
  static const String continueAs = "/continue_as_screen";
  static const String onBoarding = "/on_boarding_screen";
  static const String login = "/login_screen";
  static const String mobileVerification = "/mobile_verification_screen";
  static const String otpVerification = "/otp_verification_screen";
  static const String register = "/register_screen";
  static const String forgotPassword = "/forgot_password_screen";
  static const String resetPassword = "/reset_password_screen";
  static const String updateCompany = "/update_company_screen";
  static const String updateCandidate = "/update_candidate_screen";
  static const String mainCandidateHome = "/main_candidate_screen";
  static const String mainCompanyHome = "/main_company_screen";
  static const String privacyPolicy = "/privacy_policy";
  static const String termsAndCondition = "/terms_and_condition_screen";
  static const String aboutUs = "/about_us";
  static const String contactUs = "/contact_us_screen";
  static const String faq = "/faq_screen";
  static const String editPost = "/edit_post_screen";
  static const String viewAllApplyCandidate = "/view_all_apply_Candidate";
  static const String viewCandidateDetails = "/view_candidate_details";
}

class RoutGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    var arguments = settings.arguments;

    switch (settings.name) {
      case Routs.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routs.faq:
        return MaterialPageRoute(builder: (_) => const FaqScreen());
      case Routs.continueAs:
        return MaterialPageRoute(builder: (_) => const ContinueAsScreen());
      case Routs.onBoarding:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      case Routs.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routs.register:
        return MaterialPageRoute(
            builder: (_) => RegisterScreen(
                  arguments: arguments as SendArguments,
                ));
      case Routs.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case Routs.resetPassword:
        return MaterialPageRoute(
            builder: (_) => ResetPasswordScreen(
                  arguments: arguments as SendArguments,
                ));
      case Routs.updateCompany:
        return MaterialPageRoute(
            builder: (_) => UpdateCompanyScreen(
                  arguments: arguments as SendArguments,
                ));
      case Routs.updateCandidate:
        return MaterialPageRoute(
            builder: (_) => UpdateCandidateScreen(
                  arguments: arguments as SendArguments,
                ));
      case Routs.mainCandidateHome:
        return MaterialPageRoute(
            builder: (_) => MainCandidateScreen(
                  arguments: arguments as SendArguments,
                ));
      case Routs.editPost:
        return MaterialPageRoute(
            builder: (_) => EditPostScreen(
                  arguments: arguments as SendArguments,
                ));
      case Routs.mainCompanyHome:
        return MaterialPageRoute(
            builder: (_) => MainCompanyScreen(
                  arguments: arguments as SendArguments,
                ));
      case Routs.mobileVerification:
        return MaterialPageRoute(
            builder: (_) => MobileVerificationScreen(
                  arguments: arguments as SendArguments,
                ));
      case Routs.otpVerification:
        return MaterialPageRoute(
            builder: (_) => OtpVerificationScreen(
                  arguments: arguments as SendArguments,
                ));

      case Routs.privacyPolicy:
        return MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen());

      case Routs.termsAndCondition:
        return MaterialPageRoute(
            builder: (_) => const TermsAndConditionScreen());
      case Routs.aboutUs:
        return MaterialPageRoute(builder: (_) => const AboutUsScreen());
      case Routs.contactUs:
        return MaterialPageRoute(builder: (_) => const ContactUsScreen());
      case Routs.viewAllApplyCandidate:
        return MaterialPageRoute(
            builder: (_) => ViewAllApplyCandidate(
                  arguments: arguments as SendArguments,
                ));
      case Routs.viewCandidateDetails:
        return MaterialPageRoute(
            builder: (_) => ViewCandidateProfileScreen(
                  arguments: arguments as SendArguments,
                ));
      default:
        return null;
    }
  }
}
