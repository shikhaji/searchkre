import 'dart:core';

class EndPoints {
  static const String baseUrl = "https://searchkarein.com/android";
  static const String imageUrl = "https://searchkarein.com/uploads/";

  static const String mobileVerify = '$baseUrl/verify_mobile';
  static const String register = '$baseUrl/candidate_registration_form';
  static const String login = '$baseUrl/user_login';
  static const String getState = '$baseUrl/get_states';
  static const String getCity = '$baseUrl/get_district';
  static const String resetPassword = '$baseUrl/update_new_password';
  static const String updateKyc = '$baseUrl/update_kyc_detail';
  static const String businessCategory = '$baseUrl/get_all_category';
  static const String getProfileData = '$baseUrl/profile_content';
  static const String slider = '$baseUrl/get_sliders';
  static const String addJob = '$baseUrl/add_post';
  static const String allPost = '$baseUrl/get_all_post';
  static const String faq = '$baseUrl/get_faq';
  static const String applyJob = '$baseUrl/apply_job';
  static const String deletePost = '$baseUrl/delete_post';
  static const String allPostJobByCompany = '$baseUrl/get_all_post_by_company';
  static const String postDetails = '$baseUrl/get_post_by_id';
  static const String updatePost = '$baseUrl/update_add_post';
  static const String candidateApplyList = '$baseUrl/get_my_job_apply_list';
  static const String updateJobStatus = '$baseUrl/update_job_status';
}
