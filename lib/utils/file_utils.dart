import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'app_color.dart';

class FileUtils {
  FileUtils._();

  static final currentDate = DateTime.now();
  static final yesterdayDate = DateTime.now().subtract(const Duration(days: 1));
  static final lastWeekDate = DateTime.now().subtract(const Duration(days: 6));
  static final lastMonthDate =
      DateTime.now().subtract(const Duration(days: 29));

  static final ImagePicker _picker = ImagePicker();

  static pickImage(ImageSource source) async {
    try {
      XFile? image = await _picker.pickImage(source: source);

      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<DateTime?> pickDate(BuildContext context) async {
    final DateTime? selectedTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(3000),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData(
              primaryColor: AppColor.primaryColor,
              colorScheme:
                  const ColorScheme.light(primary: AppColor.primaryColor),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child ?? const SizedBox.shrink(),
          );
        });
    if (selectedTime != null) {
      return selectedTime;
    } else {
      return null;
    }
  }
}
