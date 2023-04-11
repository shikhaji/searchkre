import 'package:flutter/material.dart';
import 'package:search_kare/utils/app_color.dart';
import 'package:search_kare/utils/app_sizes.dart';
import 'package:search_kare/utils/app_text_style.dart';
import 'circle_icon_but.dart';

class BackAppBar extends PreferredSize {
  BackAppBar(BuildContext context,
      {Key? key,
      List<Widget> actions = const [],
      String? title,
      bool? back = true})
      : super(
          key: key,
          preferredSize: const Size.fromHeight(56),
          child: AppBar(
            actions: actions,
            title: title != null
                ? Text(
                    title,
                    style: AppTextStyle.appText,
                  )
                : null,
            centerTitle: false,
            elevation: 0,
            leadingWidth: Sizes.s70.w,
            automaticallyImplyLeading: false,
            leading: back == false
                ? const SizedBox.shrink()
                : Transform.scale(
                    scale: 0.9,
                    child: CircleIconButton.icon(
                      icon: Icons.arrow_back_ios_rounded,
                      border: Border.all(
                        width: 1.5,
                        color: AppColor.textFieldColor,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
          ),
        );
}
