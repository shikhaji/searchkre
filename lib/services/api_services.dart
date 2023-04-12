import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_kare/api/url.dart';
import 'package:search_kare/routs/app_routs.dart';
import 'package:search_kare/routs/arguments.dart';
import 'package:search_kare/utils/loader.dart';
import 'package:search_kare/utils/show_toast.dart';

class ApiService {
  Dio dio = Dio();

  Future mobileVerify(BuildContext context, {SendArguments? arguments}) async {
    try {
      FormData formData = FormData.fromMap({
        "mobile_no": arguments?.mobileNumber,
      });
      Loader.showLoader();
      Response response;
      response = await dio.post(EndPoints.mobileVerify,
          options: Options(headers: {
            "Client-Service": "frontend-client",
            "Auth-Key": 'simplerestapi',
          }),
          data: formData);

      if (response.statusCode == 200) {
        if (response.data['message'] == 0) {
          Navigator.pushNamed(context, Routs.otpVerification,
              arguments: SendArguments(
                mobileNumber: arguments?.mobileNumber,
                continueAs: arguments?.continueAs,
                otpStatus: 0,
              ));
        } else {
          showToast('Your number is already register please login');
        }
        return response;
      } else {
        print("hello false");
        showToast('Wrong');
      }
    } on DioError catch (e) {
      debugPrint(e.toString());
      return;
    } finally {
      Loader.hideLoader();
    }
  }

  Future register(BuildContext context, {FormData? data}) async {
    try {
      Loader.showLoader();
      Response response;
      response = await dio.post(EndPoints.register,
          options: Options(headers: {
            "Client-Service": "frontend-client",
            "Auth-Key": 'simplerestapi',
          }),
          data: data);

      if (response.statusCode == 200) {
        Navigator.pushNamed(context, Routs.login);
        return response;
      } else {
        showToast('Something went wrong');
      }
    } on DioError catch (e) {
      debugPrint(e.toString());
      return;
    } finally {
      Loader.hideLoader();
    }
  }

  // Future login(
  //   BuildContext context, {
  //   FormData? data,
  // }) async {
  //   try {
  //     Loader.showLoader();
  //     Response response;
  //     response = await dio.post(EndPoints.login,
  //         options: Options(headers: {
  //           "Client-Service": "frontend-client",
  //           "Auth-Key": 'simplerestapi',
  //         }),
  //         data: data);
  //     LoginModel responseData = LoginModel.fromJson(response.data);
  //     if (responseData.success == "true") {
  //       print("hello true");
  //       showToast("Login successfully");
  //       Provider.of<UserProvider>(context, listen: false)
  //           .setUserModel(responseData);
  //       Preferences.prefSetString(
  //           Preferences.keyUserId, responseData.id.toString());
  //       Preferences.prefSetString(
  //           Preferences.keyMyCode, responseData.myCode.toString());
  //       Preferences.prefSetString(
  //           Preferences.keyLoginType, responseData.companyHrmType.toString());
  //       print("responseData.companyHrmType := ${responseData.companyHrmType}");
  //       if (responseData.companyHrmType == 2) {
  //         Navigator.pushNamedAndRemoveUntil(
  //             context, Routs.partnerMainHome, (route) => false,
  //             arguments: SendArguments(bottomIndex: 0));
  //       } else {
  //         Navigator.pushNamedAndRemoveUntil(
  //             context, Routs.employeeMainHome, (route) => false,
  //             arguments: SendArguments(bottomIndex: 0));
  //       }
  //       return responseData;
  //     } else {
  //       print("hello false");
  //       showToast(responseData.message.toString());
  //     }
  //   } on DioError catch (e) {
  //     debugPrint(e.toString());
  //     return;
  //   } finally {
  //     Loader.hideLoader();
  //   }
  // }
}
