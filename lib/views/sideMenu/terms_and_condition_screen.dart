import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:search_kare/widget/app_bars.dart';
import 'package:search_kare/widget/scrollview.dart';

class TermsAndConditionScreen extends StatefulWidget {
  const TermsAndConditionScreen({Key? key}) : super(key: key);

  @override
  State<TermsAndConditionScreen> createState() =>
      _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> {
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
        title: 'Terms & Condition',
      ),
      body: CustomScroll(
        children: [
          // Html(
          //   data: _termsAndConditionModel != null &&
          //           _termsAndConditionModel!.message != null
          //       ? _termsAndConditionModel!.message.orgTermsConditions
          //       : "",
          // ),
        ],
      ),
    );
  }
}
