import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:search_kare/widget/app_bars.dart';
import 'package:search_kare/widget/scrollview.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(
        context,
        title: 'Privacy Policy',
      ),
      body: CustomScroll(
        children: [
          //  Html(
          // data: _privacyPolicyModel != null &&
          //         _privacyPolicyModel!.message != null
          //     ? _privacyPolicyModel!.message!.orgPrivacyPolicy.toString()
          //     : "",
          //  ),
        ],
      ),
    );
  }
}
