import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_kare/api/url.dart';
import 'package:search_kare/helper/preferences.dart';
import 'package:search_kare/models/business_category_list.dart';
import 'package:search_kare/models/get_candidate_profile.dart';
import 'package:search_kare/models/get_city_list_model.dart';
import 'package:search_kare/models/get_company_profile.dart';
import 'package:search_kare/models/get_slider_list.dart';
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

  Future<SliderModel> slider(BuildContext context) async {
    try {
      Loader.showLoader();
      Response response;
      response = await dio.post(
        EndPoints.slider,
        options: Options(headers: {
          "Client-Service": "frontend-client",
          "Auth-Key": 'simplerestapi',
        }),
      );

      if (response.statusCode == 200) {
        SliderModel responseData = SliderModel.fromJson(response.data);
        Loader.hideLoader();
        debugPrint('responseData ----- > ${response.data}');
        return responseData;
      } else {
        Loader.hideLoader();
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      Loader.hideLoader();
      debugPrint('Dio E  $e');
      throw e.error;
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

  Future updateCandidate(BuildContext context, int updateType,
      {FormData? data}) async {
    try {
      Loader.showLoader();
      Response response;
      response = await dio.post(EndPoints.updateKyc,
          options: Options(headers: {
            "Client-Service": "frontend-client",
            "Auth-Key": 'simplerestapi',
          }),
          data: data);

      if (response.statusCode == 200) {
        if (updateType == 2) {
          showToast('Profile Update!');
        } else {
          if (updateType == 0) {
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

  Future<BusinessCategoryList?> businessCategoryList() async {
    try {
      Loader.showLoader();
      Response response;

      response = await dio.post(
        EndPoints.businessCategory,
        options: Options(headers: {"Content-Type": 'application/json'}),
      );
      if (response.statusCode == 200) {
        BusinessCategoryList responseData =
            BusinessCategoryList.fromJson(response.data);
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

  Future<GetCandidateProfile?> getCandidateProfile() async {
    try {
      Loader.showLoader();
      Response response;
      FormData formData = FormData.fromMap({"loginid": preferences.loginId});
      response = await dio.post(EndPoints.getProfileData,
          options: Options(headers: {"Content-Type": 'application/json'}),
          data: formData);

      if (response.statusCode == 200) {
        GetCandidateProfile responseData =
            GetCandidateProfile.fromJson(response.data);
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

  Future<GetCompanyProfile?> getCompanyProfile() async {
    try {
      Loader.showLoader();
      Response response;
      FormData formData = FormData.fromMap({"loginid": preferences.loginId});
      response = await dio.post(EndPoints.getProfileData,
          options: Options(headers: {"Content-Type": 'application/json'}),
          data: formData);

      if (response.statusCode == 200) {
        GetCompanyProfile responseData =
            GetCompanyProfile.fromJson(response.data);
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

        if (response.data['BRANCH_KYC_STATUS'] == "0") {
          if (response.data['COMPANY_HRM_TYPE'] == "2") {
            Navigator.pushNamed(context, Routs.updateCandidate,
                arguments: SendArguments(
                    mobileNumber: response.data['PHONE'],
                    kycLoginId: response.data['id']));
          } else {
            Navigator.pushNamed(context, Routs.updateCompany,
                arguments: SendArguments(
                    mobileNumber: response.data['PHONE'],
                    kycLoginId: response.data['id']));
          }
        } else {
          preferences.loginId = response.data['id'];
          preferences.loginType = response.data['COMPANY_HRM_TYPE'];
          preferences.profileUpdate = response.data['BRANCH_KYC_STATUS'];
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
