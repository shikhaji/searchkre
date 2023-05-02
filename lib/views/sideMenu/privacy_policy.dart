import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:search_kare/widget/app_bars.dart';
import 'package:search_kare/widget/scrollview.dart';

import '../../models/get_app_details.dart';
import '../../services/api_services.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  Logo? getAppData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ApiService().getAppDetails().then((value) {
      if (value != null) {
        setState(() {
          getAppData = value.logo;
        });
      }
    });
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
           Html(
          data: getAppData != null &&
              getAppData!.orgPrivacyPolicy != null
              ?  getAppData!.orgPrivacyPolicy
              : "",
           ),
        ],
      ),
    );
  }
}
