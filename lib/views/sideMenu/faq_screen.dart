import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:search_kare/models/faq_model.dart';
import 'package:search_kare/services/api_services.dart';
import 'package:search_kare/utils/app_color.dart';
import 'package:search_kare/utils/app_text_style.dart';
import 'package:search_kare/widget/app_bars.dart';
import 'package:search_kare/widget/scrollview.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  FaqData? faqData;
  @override
  void initState() {
    super.initState();
    ApiService().getFaq().then((value) {
      if (value != null) {
        faqData = value.message;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(
        context,
        title: 'FAQ',
      ),
      body: CustomScroll(
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: faqData?.fquestion.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: const EdgeInsets.all(13),
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColor.textFieldColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "${faqData?.fquestion[index].fquestion}",
                            style: AppTextStyle.appText,
                          )),
                      Text(
                        "${faqData?.fquestion[index].fanswer}",
                        style: AppTextStyle.s16W6Gray,
                      )
                    ],
                  ),
                );
              })
        ],
      ),
    );
  }
}
