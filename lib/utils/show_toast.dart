import 'package:fluttertoast/fluttertoast.dart';

import 'app_color.dart';

void showToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColor.primaryColor,
      textColor: AppColor.white,
      fontSize: 16.0);
}
