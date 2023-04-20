import 'dart:developer';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:search_kare/routs/app_routs.dart';
import 'package:search_kare/utils/screen_utils.dart';
import 'package:search_kare/utils/theme_utils.dart';
import 'helper/preferences.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Preferences.init();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const SearchKare());
}

class SearchKare extends StatelessWidget {
  const SearchKare({super.key});

  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeUtils.lightTheme,
      initialRoute: Routs.splash,
      onGenerateRoute: RoutGenerator.generateRoute,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: const _ScrollBehaviorModified(),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              ScreenUtil.init(constraints,
                  designSize:
                      Size(constraints.maxWidth, constraints.maxHeight));
              child = botToastBuilder(context, child);
              return child ?? const SizedBox.shrink();
            },
          ),
        );
      },
    );
  }
}

class _ScrollBehaviorModified extends ScrollBehavior {
  const _ScrollBehaviorModified();
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return const ClampingScrollPhysics();
    }
  }
}
