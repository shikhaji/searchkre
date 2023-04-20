import 'package:flutter/material.dart';
import 'package:search_kare/api/url.dart';
import 'package:search_kare/models/get_slider_list.dart';
import 'package:search_kare/services/api_services.dart';
import 'package:search_kare/utils/app_color.dart';
import 'package:search_kare/utils/app_sizes.dart';
import 'package:search_kare/utils/app_text_style.dart';
import 'package:search_kare/utils/screen_utils.dart';
import 'package:search_kare/views/commonPopUp/delete_post_popup.dart';
import 'package:search_kare/widget/app_button.dart';
import 'package:search_kare/widget/custom_sized_box.dart';
import 'package:search_kare/widget/drawer_widget.dart';
import 'package:search_kare/widget/scrollview.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CandidateHomeScreen extends StatefulWidget {
  const CandidateHomeScreen({Key? key}) : super(key: key);

  @override
  State<CandidateHomeScreen> createState() => _CandidateHomeScreenState();
}

class _CandidateHomeScreenState extends State<CandidateHomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CarouselController buttonCarouselController = CarouselController();
  List<SliderData> sliderData = [];
  int _selectedSliderIndex = 0;
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  void initState() {
    ApiService().slider(context).then((value) {
      if (value != null) {
        setState(() {
          sliderData = value.message;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Home",
            style: AppTextStyle.appText,
          ),
          leading: IconButton(
              onPressed: () {
                openDrawer();
              },
              icon: const Icon(Icons.menu_open_sharp)),
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          elevation: 0,
          width: ScreenUtil().screenWidth * 0.8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(Sizes.s20.r),
              bottomRight: Radius.circular(Sizes.s20.r),
            ),
          ),
          child: const DrawerWidget(),
        ),
        body: CustomScroll(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBoxH20(),
            SizedBox(
              width: double.infinity,
              child: CarouselSlider.builder(
                  carouselController: buttonCarouselController,
                  itemCount: sliderData.length ?? 0,
                  itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) =>
                      Padding(
                          padding: const EdgeInsets.only(right: 3, left: 3),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                    image: NetworkImage(
                                      '${EndPoints.imageUrl}${sliderData[itemIndex].sliderImage}',
                                    ),
                                    fit: BoxFit.cover)),
                          )),
                  options: CarouselOptions(
                    onPageChanged: (index, _) {
                      setState(() {
                        _selectedSliderIndex = index;
                      });
                    },
                    aspectRatio: 15 / 8,
                    viewportFraction: 1,
                    initialPage: 0,
                    autoPlay: true,
                    enableInfiniteScroll: false,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  )),
            ),
            SizedBoxH18(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                  sliderData.length,
                  (index) => Indicator(
                      isActive: _selectedSliderIndex == index ? true : false),
                )
              ],
            ),
            SizedBoxH18(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(10, (index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                        margin: const EdgeInsets.all(Sizes.s8),
                        padding: const EdgeInsets.only(
                            top: Sizes.s12,
                            bottom: Sizes.s12,
                            left: Sizes.s12,
                            right: Sizes.s12),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.4), //color of shadow
                                spreadRadius: 2, //spread radius
                                blurRadius: 2, // blur radius
                                offset: const Offset(0, 2),
                              )
                            ],
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(Sizes.s12)),
                        child: Text(
                          "Marketing and research",
                          style: AppTextStyle.appText.copyWith(
                            fontSize: Sizes.s16,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                  );
                }),
              ),
            ),
            SizedBoxH20(),
            ListView.builder(
                shrinkWrap: true,
                itemCount: 8,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 12),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: AppColor.textFieldColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            "Flutter Developer",
                            style: AppTextStyle.appText
                                .copyWith(fontSize: Sizes.s16),
                          ),
                        ),
                        SizedBoxH8(),
                        Image.network(
                          "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg",
                          width: double.infinity,
                        ),
                        SizedBoxH8(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "A task topic is intended for a procedure that describes how to accomplish a task. A task topic lists a series of steps that users follow to produce an intended outcome. So a short description for a task topic should explain to the reader the purpose of the",
                            style: AppTextStyle.greySubTitle
                                .copyWith(color: AppColor.black),
                          ),
                        ),
                        SizedBoxH8(),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: AppButton(
                            title: "Apply",
                            onPressed: () {
                              DeletePostPopUp.show(context, 'Apply job',
                                      'Are you sure you want to apply job?')
                                  .then((value) async {
                                if (value == true) {}
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  );
                })
          ],
        ));
  }
}

class Indicator extends StatelessWidget {
  final bool isActive;
  const Indicator({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      height: 10.0,
      margin: const EdgeInsets.symmetric(horizontal: 3.0),
      width: isActive ? 10.0 : 10.0,
      decoration: BoxDecoration(
          color: isActive ? Colors.black : Colors.black,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.black, width: 2.0)),
    );
  }
}
