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
import 'package:search_kare/views/compnayDashboard/main_company_screen.dart';
import 'package:search_kare/views/compnayDashboard/post_job_screen.dart';
import 'package:search_kare/views/onBoarding/on_boarding_screen.dart';
import 'package:search_kare/views/splash/splash_screen.dart';
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
  static const String postJob = "/post_job_screen";
}

class RoutGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    var arguments = settings.arguments;

    switch (settings.name) {
      case Routs.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
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
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());
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
      case Routs.postJob:
        return MaterialPageRoute(builder: (_) => const PostJobScreen());

      default:
        return null;
    }
  }
}
