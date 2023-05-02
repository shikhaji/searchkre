import 'package:flutter/material.dart';
import 'package:search_kare/widget/app_bars.dart';
import 'package:search_kare/widget/scrollview.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../models/get_app_details.dart';
import '../../services/api_services.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
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
        title: 'About Us',
      ),
      body: CustomScroll(
        children: [
          Html(
            data: getAppData != null &&
                getAppData!.orgAbout != null
                ?  getAppData!.orgAbout
                : "",
          ),
        ],
      ),
    );
  }
}
