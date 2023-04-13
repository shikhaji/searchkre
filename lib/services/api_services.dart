import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_kare/api/url.dart';
import 'package:search_kare/helper/preferences.dart';
import 'package:search_kare/models/get_city_list_model.dart';
import 'package:search_kare/models/get_state_list_model.dart';
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
        return response;
      } else {
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

  Future<GetStateListModel?> getState() async {
    try {
      Loader.showLoader();
      Response response;
      response = await dio.post(
        EndPoints.getState,
        options: Options(headers: {"Content-Type": 'application/json'}),
      );
      if (response.statusCode == 200) {
        GetStateListModel responseData =
            GetStateListModel.fromJson(response.data);
        Loader.hideLoader();
        return responseData;
      } else {
        Loader.hideLoader();
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      Loader.hideLoader();
      debugPrint('Dio E  $e');
    } finally {
      Loader.hideLoader();
    }
    return null;
  }

  Future<GetCityListModel?> getCity(String stateId) async {
    try {
      Loader.showLoader();
      Response response;
      FormData formData = FormData.fromMap({"stateid": stateId});
      response = await dio.post(EndPoints.getCity,
          options: Options(headers: {"Content-Type": 'application/json'}),
          data: formData);
      if (response.statusCode == 200) {
        GetCityListModel responseData =
            GetCityListModel.fromJson(response.data);
        Loader.hideLoader();
        return responseData;
      } else {
        Loader.hideLoader();
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      Loader.hideLoader();
      debugPrint('Dio E  $e');
    } finally {
      Loader.hideLoader();
    }
    return null;
  }

  Future login(
    BuildContext context,
    String mobile, {
    FormData? data,
  }) async {
    try {
      Loader.showLoader();
      Response response;
      response = await dio.post(EndPoints.login,
          options: Options(headers: {
            "Client-Service": "frontend-client",
            "Auth-Key": 'simplerestapi',
          }),
          data: data);

      if (response.data['message'] == 'ok') {
        showToast("Login successfully");
        preferences.loginId = response.data['id'];
        preferences.loginType = response.data['COMPANY_HRM_TYPE'];
        preferences.profileUpdate = response.data['BRANCH_KYC_STATUS'];

        if (response.data['BRANCH_KYC_STATUS'] == "0") {
          if (response.data['COMPANY_HRM_TYPE'] == "2") {
            Navigator.pushNamed(context, Routs.updateCandidate,
                arguments: SendArguments(mobileNumber: mobile));
          } else {
            Navigator.pushNamed(context, Routs.updateCompany,
                arguments: SendArguments(mobileNumber: mobile));
          }
        } else {
          if (response.data['COMPANY_HRM_TYPE'] == "2") {
            Navigator.pushNamedAndRemoveUntil(
                context, Routs.mainCandidateHome, (route) => false,
                arguments: SendArguments(bottomIndex: 0));
          } else {
            Navigator.pushNamedAndRemoveUntil(
                context, Routs.mainCompanyHome, (route) => false,
                arguments: SendArguments(bottomIndex: 0));
          }
        }

        return response;
      } else {
        showToast("Invalid login credentials");
      }
    } on DioError catch (e) {
      debugPrint(e.toString());
      return;
    } finally {
      Loader.hideLoader();
    }
  }

  Future resetPassword(BuildContext context, {FormData? data}) async {
    try {
      Loader.showLoader();
      Response response;
      response = await dio.post(EndPoints.resetPassword,
          options: Options(headers: {
            "Client-Service": "frontend-client",
            "Auth-Key": 'simplerestapi',
          }),
          data: data);

      if (response.statusMessage == 200) {
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
}
