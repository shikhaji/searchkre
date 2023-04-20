import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:search_kare/api/url.dart';
import 'package:search_kare/helper/preferences.dart';
import 'package:search_kare/models/business_category.dart';
import 'package:search_kare/models/city_model.dart';
import 'package:search_kare/models/get_company_profile.dart';
import 'package:search_kare/models/state_model.dart';
import 'package:search_kare/routs/arguments.dart';
import 'package:search_kare/services/api_services.dart';
import 'package:search_kare/utils/app_asset.dart';
import 'package:search_kare/utils/app_color.dart';
import 'package:search_kare/utils/app_sizes.dart';
import 'package:search_kare/utils/app_text.dart';
import 'package:search_kare/utils/app_text_style.dart';
import 'package:search_kare/utils/screen_utils.dart';
import 'package:search_kare/utils/validation_mixin.dart';
import 'package:search_kare/views/commonPopUp/business_category_picker.dart';
import 'package:search_kare/views/commonPopUp/city_picker.dart';
import 'package:search_kare/views/commonPopUp/state_picker.dart';
import 'package:search_kare/widget/app_bars.dart';
import 'package:search_kare/widget/app_button.dart';
import 'package:search_kare/widget/custom_sized_box.dart';
import 'package:search_kare/widget/app_text_field.dart';
import 'package:search_kare/widget/drawer_widget.dart';
import 'package:search_kare/widget/scrollview.dart';

class CompanyMyProfileScreen extends StatefulWidget {
  final SendArguments? arguments;
  const CompanyMyProfileScreen({Key? key, this.arguments}) : super(key: key);

  @override
  State<CompanyMyProfileScreen> createState() => _CompanyMyProfileScreenState();
}

class _CompanyMyProfileScreenState extends State<CompanyMyProfileScreen>
    with ValidationMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _oName = TextEditingController();
  final TextEditingController _bName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _mNumber = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _zipCode = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _businessType = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  StateModel stateModel = StateModel();
  CityModel cityModel = CityModel();
  BusinessCategory businessCategory = BusinessCategory();
  var profileUrl;
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  GetProfileData? getProfileData;
  XFile? selectedDocument;

  @override
  void initState() {
    ApiService().getCompanyProfile().then((value) {
      if (value != null) {
        setState(() {
          getProfileData = value.message;
          _oName.text = getProfileData!.profile.branchName;
          _bName.text = getProfileData!.profile.branchFirmName;
          _email.text = getProfileData!.profile.branchEmail;
          _mNumber.text = getProfileData!.profile.branchContact;
          _state.text = getProfileData!.profile.branchState;
          _city.text = getProfileData!.profile.branchCity;
          _zipCode.text = getProfileData!.profile.branchZipCode;
          _address.text = getProfileData!.profile.branchAddress;
          _businessType.text = getProfileData!.profile.brandName;
          profileUrl = getProfileData!.profile.branchPhoto;
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
          "My Profile",
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
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: CustomScroll(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBoxH46(),
            appText("Personal Details", style: AppTextStyle.appText),
            SizedBoxH14(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildProfileImageWidget(
                  context,
                ),
              ],
            ),
            SizedBoxH28(),
            AppTextField(
              title: "Business Name",
              controller: _bName,
              hintText: "Enter your business name",
              validator: businessNameValidator,
            ),
            AppTextField(
              title: "Owner Name",
              controller: _oName,
              hintText: "Enter your owner name",
              validator: nameValidator,
            ),
            AppTextField(
              title: "Email ID",
              controller: _email,
              hintText: "Enter your email-id",
              validator: emailValidator,
            ),
            AppTextField(
              title: "Mobile Number",
              controller: _mNumber,
              hintText: "Enter mobile number",
              readOnly: true,
              keyboardInputType: TextInputType.phone,
            ),
            SizedBoxH14(),
            appText("Location", style: AppTextStyle.appText),
            SizedBoxH14(),
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    title: "State",
                    controller: _state,
                    hintText: "Enter your state",
                    validator: stateValidation,
                    readOnly: true,
                    onTap: () async {
                      stateModel = await StatePickerPopup.show(context);
                      _state.text = stateModel.stateName ?? '';
                      _city.clear();
                      setState(() {});
                    },
                  ),
                ),
                SizedBoxW8(),
                Expanded(
                  child: AppTextField(
                    title: "City",
                    controller: _city,
                    hintText: "Enter your city",
                    validator: cityValidation,
                    readOnly: true,
                    onTap: () async {
                      cityModel = await CityPickerPopup.show(
                          context, "${stateModel.stateId}");
                      _city.text = cityModel.districtName ?? '';
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            AppTextField(
              title: "Zipcode",
              controller: _zipCode,
              hintText: "Enter your zipCode",
              validator: zipCodeValidation,
            ),
            AppTextField(
              title: "Address",
              controller: _address,
              hintText: "Enter your address",
              validator: addressValidation,
            ),
            SizedBoxH14(),
            appText("Business", style: AppTextStyle.appText),
            SizedBoxH14(),
            AppTextField(
              title: "Business Type",
              controller: _businessType,
              readOnly: true,
              onTap: () async {
                businessCategory =
                    await BusinessCategoryPickerPopup.show(context);
                _businessType.text = businessCategory.brandName ?? '';
                setState(() {});
              },
              hintText: "Enter your business type",
              validator: businessTypeValidation,
            ),
            SizedBoxH28(),
            AppButton(
                title: "Update",
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    var profileImage;
                    if (selectedDocument != null) {
                      profileImage =
                          await MultipartFile.fromFile(selectedDocument!.path);
                    } else {
                      profileImage = getProfileData?.profile.branchPhoto;
                    }
                    FormData data() {
                      return FormData.fromMap({
                        "loginid": preferences.loginId,
                        "profile_type": 3,
                        'owner_name': _oName.text.trim(),
                        "business_name": _bName.text.trim(),
                        "phone": _mNumber.text.trim(),
                        "email": _email.text.trim(),
                        "state": _state.text.trim(),
                        "city": _city.text.trim(),
                        "zip_code": _zipCode.text.trim(),
                        "business_address": _address.text.trim(),
                        "fileToUpload1": profileImage,
                        "business_category": businessCategory.id,
                      });
                    }

                    ApiService().updateCandidate(context, 2, data: data());
                  }
                }),
            SizedBoxH28(),
          ],
        ),
      )),
    );
  }

  Widget buildProfileImageWidget(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: 75,
          child: ClipOval(
            child: selectedDocument != null
                ? Image.file(File(selectedDocument!.path),
                    height: 160, width: 160, fit: BoxFit.cover)
                : profileUrl != null && profileUrl != ''
                    ? Image.network('${EndPoints.imageUrl}$profileUrl',
                        height: 160, width: 160, fit: BoxFit.cover)
                    : Image.asset(AppAsset.dummyAvatar,
                        height: 160, width: 160, fit: BoxFit.cover),
          ),
        ),
        Positioned.fill(
          bottom: -12,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: () async {
                showDialogForUserImage(1);
              },
              child: CircleAvatar(
                backgroundColor: AppColor.white,
                radius: Sizes.s20.r,
                child: CircleAvatar(
                  radius: Sizes.s18.r,
                  backgroundColor: AppColor.primaryColor,
                  child: SvgPicture.asset(
                    AppAsset.camera,
                    height: Sizes.s20.h,
                    width: Sizes.s20.w,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  showDialogForUserImage(int imgIndex) {
    showCupertinoModalPopup(
      context: context,
      builder: (a) => ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Material(
          child: Container(
            decoration: const BoxDecoration(
              color: AppColor.primaryColor,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  color: AppColor.primaryColor,
                  child: const Center(
                    child: Text(
                      "Select Image",
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColor.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(a).pop();
                        selectImage(ImageSource.gallery, 1);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.image_rounded,
                            color: AppColor.white,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Gallery",
                            style: AppTextStyle.greySubTitle
                                .copyWith(color: AppColor.white),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height / 12,
                      width: 3,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(a).pop();
                        selectImage(ImageSource.camera, 1);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.camera_alt_rounded,
                            color: AppColor.white,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Camera",
                            style: AppTextStyle.greySubTitle
                                .copyWith(color: AppColor.white),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  selectImage(ImageSource source, int imgIndex) async {
    final ImagePicker imagePicker = ImagePicker();
    if (imgIndex == 1) {
      selectedDocument = await imagePicker.pickImage(source: source);
      setState(() {});
    }
  }
}
