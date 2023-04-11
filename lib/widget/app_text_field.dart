import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:search_kare/utils/app_color.dart';
import 'package:search_kare/utils/app_sizes.dart';
import 'package:search_kare/utils/app_text.dart';
import 'package:search_kare/utils/app_text_style.dart';
import 'custom_sized_box.dart';

class AppTextField extends StatelessWidget {
  final String? hintText;
  final String? title;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final bool readOnly;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final TextInputType keyboardInputType;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffix;
  final Widget? prefix;
  final String? counterText;
  final Color? textColor;
  final int? maxLength;
  final int? maxLines;
  final Color? color;
  final TextStyle? hintStyle;
  final String? instructionsText;
  final bool? instructions;
  final EdgeInsets? contentPadding;
  final BoxConstraints? suffixIconConstraints;

  const AppTextField({
    Key? key,
    this.controller,
    this.title,
    this.maxLines,
    this.counterText,
    this.hintText,
    this.textInputAction,
    this.onChanged,
    this.maxLength,
    this.inputFormatters,
    this.readOnly = false,
    this.obscureText = false,
    this.validator,
    this.onTap,
    this.suffix,
    this.prefix,
    this.textColor,
    this.color,
    this.instructionsText,
    this.instructions = false,
    this.hintStyle,
    this.contentPadding,
    this.suffixIconConstraints,
    this.keyboardInputType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        appText(title!,
            style: AppTextStyle.s26W7Black.copyWith(fontSize: Sizes.s18)),
        SizedBoxH8(),
        TextFormField(
          obscuringCharacter: "*",
          autocorrect: false,
          controller: controller,
          readOnly: readOnly,
          textInputAction: textInputAction ?? TextInputAction.next,
          inputFormatters: inputFormatters,
          keyboardType: keyboardInputType,
          onChanged: onChanged,
          onTap: onTap,
          obscureText: obscureText,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: AppTextStyle.s16W6Gray.copyWith(color: Colors.black),
          maxLength: maxLength,
          maxLines: maxLines ?? 1,
          decoration: InputDecoration(
            isDense: true,
            hintStyle: AppTextStyle.s14W4HintText,
            fillColor: color ?? AppColor.textFieldColor,
            filled: true,
            hintText: hintText,
            counterText: counterText,
            suffixIconConstraints: suffixIconConstraints ??
                BoxConstraints(
                  minHeight: Sizes.s30.h,
                  minWidth: Sizes.s30.w,
                ),
            suffixIcon: suffix,
            prefixIcon: prefix,
            contentPadding: contentPadding ?? EdgeInsets.all(Sizes.s16.h),
            border: _outlineInputBorder(Theme.of(context).cardColor),
            enabledBorder: _outlineInputBorder(Theme.of(context).cardColor),
            focusedBorder: _outlineInputBorder(Theme.of(context).cardColor),
            errorBorder: _outlineInputBorder(Colors.red),
            focusedErrorBorder: _outlineInputBorder(Colors.red),
          ),
          validator: validator,
        ),
        instructions!
            ? const SizedBox.shrink()
            : Column(children: [
                const SizedBox(height: Sizes.s2),
                appText(
                  instructionsText ?? "",
                  style: AppTextStyle.s14W4HintText,
                ),
              ]),
        SizedBox(height: Sizes.s2.h)
      ],
    );
  }

  OutlineInputBorder _outlineInputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(Sizes.s12.r),
      borderSide: BorderSide(width: 0.2, color: color),
    );
  }
}
