import 'package:flutter/material.dart';
import 'package:search_kare/widget/app_bars.dart';
import 'package:search_kare/widget/scrollview.dart';
import 'package:flutter_html/flutter_html.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(
        context,
        title: 'About Us',
      ),
      body: const CustomScroll(
        children: [
          // Html(
          //   data: _aboutUsModel != null && _aboutUsModel!.message != null
          //       ? _aboutUsModel!.message.aboutUs
          //       : "",
          // ),
        ],
      ),
    );
  }
}
