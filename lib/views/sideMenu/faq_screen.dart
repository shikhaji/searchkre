// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:search_kare/models/faq_model.dart';
// import 'package:search_kare/services/api_services.dart';
// import 'package:search_kare/utils/app_color.dart';
// import 'package:search_kare/utils/app_text_style.dart';
// import 'package:search_kare/widget/app_bars.dart';
// import 'package:search_kare/widget/scrollview.dart';
//
// class FaqScreen extends StatefulWidget {
//   const FaqScreen({Key? key}) : super(key: key);
//
//   @override
//   State<FaqScreen> createState() => _FaqScreenState();
// }
//
// class _FaqScreenState extends State<FaqScreen> {
//   FaqData? faqData;
//   @override
//   void initState() {
//     super.initState();
//     ApiService().getFaq().then((value) {
//       if (value != null) {
//         faqData = value.message;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: BackAppBar(
//         context,
//         title: 'FAQ',
//       ),
//       body: CustomScroll(
//         children: [
//           ListView.builder(
//               shrinkWrap: true,
//               itemCount: faqData?.fquestion.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return Container(
//                   padding: const EdgeInsets.all(13),
//                   margin: const EdgeInsets.symmetric(vertical: 12),
//                   decoration: BoxDecoration(
//                     color: AppColor.textFieldColor,
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       TextButton(
//                           onPressed: () {},
//                           child: Text(
//                             "${faqData?.fquestion[index].fquestion}",
//                             style: AppTextStyle.appText,
//                           )),
//                       Text(
//                         "${faqData?.fquestion[index].fanswer}",
//                         style: AppTextStyle.s16W6Gray,
//                       )
//                     ],
//                   ),
//                 );
//               })
//         ],
//       ),
//     );
//   }
//

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import '../../models/faq_model.dart';
import '../../services/api_services.dart';
import '../../utils/app_color.dart';
import '../../utils/app_text_style.dart';
import '../../widget/app_bars.dart';
import '../../widget/scrollview.dart';


class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key})
      : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {

  FaqData? faqData;
  @override
  void initState() {
    super.initState();
    ApiService().getFaq().then((value) {
      setState(() {
        if (value != null) {
          faqData = value.message;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(
        context,
        title: 'FAQ',
      ),
      body: faqData != null ? CustomScroll(
        children: [
          // Center(
          //   child: Column(
          //     children: [
          //       for (var i = 0; i < faqData!.fquestion.length; i++) ...{
          //         GFAccordion(
          //           textStyle: AppTextStyle.appText,
          //           title:  faqData != null && faqData!.fquestion != null ? faqData?.fquestion[i].fquestion : "",
          //           content: faqData != null && faqData!.fquestion != null ? faqData?.fquestion[i].fanswer : "",
          //           // collapsedIcon: Icon(Icons.add),
          //           // expandedIcon: Icon(Icons.minimize)
          //         ),
          //       },
          //     ],
          //   ),
          // ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: faqData!.fquestion.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColor.textFieldColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GFAccordion(
                        textStyle: AppTextStyle.appText,
                        title: faqData != null && faqData!.fquestion != null ? faqData?.fquestion[index].fquestion : "",
                        content: faqData != null && faqData!.fquestion != null ? faqData?.fquestion[index].fanswer : "",
                        // collapsedIcon: Icon(Icons.add),
                        // expandedIcon: Icon(Icons.minimize)
                      ),
                    ],
                  ),
                );
              })
        ],
      ) : SizedBox.shrink(),
    );
  }
}
