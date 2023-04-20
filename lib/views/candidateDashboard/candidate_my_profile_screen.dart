import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:search_kare/api/url.dart';
import 'package:search_kare/helper/preferences.dart';
import 'package:search_kare/models/city_model.dart';
import 'package:search_kare/models/get_candidate_profile.dart';
import 'package:search_kare/models/state_model.dart';
import 'package:search_kare/routs/arguments.dart';
import 'package:search_kare/services/api_services.dart';
import 'package:search_kare/utils/app_asset.dart';
import 'package:search_kare/utils/app_color.dart';
import 'package:search_kare/utils/app_sizes.dart';
import 'package:search_kare/utils/app_text.dart';
import 'package:search_kare/utils/app_text_style.dart';
import 'package:search_kare/utils/file_utils.dart';
import 'package:search_kare/utils/loader.dart';
import 'package:search_kare/utils/screen_utils.dart';
import 'package:search_kare/utils/validation_mixin.dart';
import 'package:search_kare/views/commonPopUp/city_picker.dart';
import 'package:search_kare/views/commonPopUp/state_picker.dart';
import 'package:search_kare/widget/app_button.dart';
import 'package:search_kare/widget/custom_sized_box.dart';
import 'package:search_kare/widget/app_text_field.dart';
import 'package:search_kare/widget/drawer_widget.dart';
import 'package:search_kare/widget/scrollview.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';

class CandidateMyProfileScreen extends StatefulWidget {
  final SendArguments? arguments;
  const CandidateMyProfileScreen({Key? key, this.arguments}) : super(key: key);

  @override
  State<CandidateMyProfileScreen> createState() =>
      _CandidateMyProfileScreenState();
}

class _CandidateMyProfileScreenState extends State<CandidateMyProfileScreen>
    with ValidationMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _fName = TextEditingController();
  final TextEditingController _mName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _mNumber = TextEditingController();
  final ValueNotifier<DateTime?> selectDate = ValueNotifier(null);
  final TextEditingController _dob = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _zipCode = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _qualification = TextEditingController();
  final TextEditingController _experience = TextEditingController();

  File? _file;
  XFile? selectedDocument;
  var profileUrl;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  StateModel stateModel = StateModel();
  CityModel cityModel = CityModel();

  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  GetProfileData? getProfileData;

  @override
  void initState() {
    ApiService().getCandidateProfile().then((value) {
      if (value != null) {
        setState(() {
          getProfileData = value.message;
          _name.text = getProfileData!.profile.branchName;
          _fName.text = getProfileData!.profile.branchFatherName;
          _mName.text = getProfileData!.profile.branchMotherName;
          _email.text = getProfileData!.profile.branchEmail;
          _dob.text = getProfileData!.profile.branchDob;
          _mNumber.text = getProfileData!.profile.branchContact;
          _state.text = getProfileData!.profile.branchState;
          _city.text = getProfileData!.profile.branchCity;
          _zipCode.text = getProfileData!.profile.branchZipCode;
          _address.text = getProfileData!.profile.branchAddress;
          _qualification.text = getProfileData!.profile.branchQualification;
          _experience.text = getProfileData!.profile.branchExperience;
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildProfileImageWidget(
                  context,
                ),
              ],
            ),
            SizedBoxH28(),
            appText("Personal Details", style: AppTextStyle.appText),
            SizedBoxH14(),
            AppTextField(
              title: "Name",
              controller: _name,
              hintText: "Enter your name",
              validator: nameValidator,
            ),
            AppTextField(
              title: "Father Name",
              controller: _fName,
              hintText: "Enter your father name",
              validator: fatherNameValidator,
            ),
            AppTextField(
              title: "Mother Name",
              controller: _mName,
              hintText: "Enter your mother name",
              validator: motherNameValidator,
            ),
            AppTextField(
              title: "Email ID",
              controller: _email,
              hintText: "Enter your email-id",
              validator: emailValidator,
            ),
            Row(
              children: [
                ValueListenableBuilder(
                  valueListenable: selectDate,
                  builder:
                      (BuildContext context, DateTime? value, Widget? child) {
                    return Flexible(
                        child: AppTextField(
                      title: "Date of Birth",
                      validator: dobValidation,
                      readOnly: true,
                      controller: _dob,
                      hintText: selectDate.value == null
                          ? "Please select date"
                          : _dob.text,
                      onTap: () async {
                        selectDate.value = await FileUtils.pickDate(context);
                        _dob.text = FileUtils.getFormatDate(selectDate.value
                            .toString()); //   debugPrint(pickedDate.value);
                      },
                    ));
                  },
                ),
              ],
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
            appText("Education", style: AppTextStyle.appText),
            SizedBoxH14(),
            AppTextField(
              title: "Qualification",
              controller: _qualification,
              hintText: "Enter your qualification",
              validator: qualificationValidation,
            ),
            AppTextField(
              title: "Experience",
              controller: _experience,
              hintText: "Enter your Experience",
              validator: experienceValidation,
            ),
            uploadBox(
              'Upload Your CV',
              _file != null ? _file!.path : '',
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
                    var cv;
                    if (_file != null) {
                      cv = await MultipartFile.fromFile(_file!.path);
                    } else {
                      cv = getProfileData?.profile.branchCv;
                    }
                    FormData data() {
                      return FormData.fromMap({
                        "loginid": preferences.loginId,
                        "profile_type": 2,
                        'name': _name.text.trim(),
                        "father_name": _fName.text.trim(),
                        "mother_name": _mName.text.trim(),
                        "phone": _mNumber.text.trim(),
                        "email": _email.text.trim(),
                        "state": _state.text.trim(),
                        "city": _city.text.trim(),
                        "zip_code": _zipCode.text.trim(),
                        "business_address": _address.text.trim(),
                        "qualification": _qualification.text.trim(),
                        "experience": _experience.text.trim(),
                        "dob": _dob.text.trim(),
                        "fileToUpload1": profileImage,
                        "fileToUpload2": cv,
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
                          const Icon(
                            Icons.image_rounded,
                            color: AppColor.white,
                          ),
                          const SizedBox(height: 10),
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
                          const Icon(
                            Icons.camera_alt_rounded,
                            color: AppColor.white,
                          ),
                          const SizedBox(height: 10),
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

  Widget uploadBox(String title, String image) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).cardColor,
          border: RDottedLineBorder.all(
            color: Colors.grey,
            width: 1,
          ),
        ),
        width: ScreenUtil().screenWidth,
        // height: Sizes.s180.h,
        child: Column(
          children: [
            ListTile(
              title: Text(
                image != ""
                    ? image.split("/").last
                    : getProfileData != null
                        ? getProfileData!.profile.branchCv
                        : "",
                style: AppTextStyle.appText.copyWith(fontSize: Sizes.s12),
              ),
              leading: const Icon(
                Icons.picture_as_pdf,
                color: Colors.red,
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: GestureDetector(
                  onTap: () async {
                    FilePickerResult? result = await FilePicker.platform
                        .pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['pdf'],
                            allowMultiple: false);
                    if (result == null) return;
                    final path = result.files.single.path;
                    setState(() => _file = File(path!));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColor.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Upload",
                          style: AppTextStyle.appText
                              .copyWith(fontSize: Sizes.s14),
                        ),
                        SizedBoxW6(),
                        const Icon(
                          Icons.upload_file_outlined,
                        )
                      ],
                    ),
                  ),
                )),
                SizedBoxW10(),
                image != ""
                    ? Expanded(
                        child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColor.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "No View",
                              style: AppTextStyle.appText
                                  .copyWith(fontSize: Sizes.s14),
                            ),
                            SizedBoxW6(),
                            const Icon(
                              Icons.visibility_off,
                            )
                          ],
                        ),
                      ))
                    : Expanded(
                        child: GestureDetector(
                        onTap: () {
                          Loader.showLoader();
                          pdfView(
                              url:
                                  '${EndPoints.imageUrl}${getProfileData!.profile.branchCv}',
                              filename: getProfileData!.profile.branchCv);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColor.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "View",
                                style: AppTextStyle.appText
                                    .copyWith(fontSize: Sizes.s14),
                              ),
                              SizedBoxW6(),
                              const Icon(
                                Icons.remove_red_eye,
                              )
                            ],
                          ),
                        ),
                      )),
              ],
            )
          ],
        ));
  }

  Future pdfView({required String url, String? filename}) async {
    final file = await openFile(url, filename!);
    if (file == null) return;
    OpenFile.open(file.path);
    Loader.hideLoader();
  }

  Future<File?> openFile(String url, String name) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/$name');

    final response = await Dio().get(url,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            receiveTimeout: 0));

    final ref = file.openSync(mode: FileMode.write);
    ref.writeFromSync(response.data);
    await ref.close();
    return file;
  }

  selectImage(ImageSource source, int imgIndex) async {
    final ImagePicker imagePicker = ImagePicker();
    if (imgIndex == 1) {
      selectedDocument = await imagePicker.pickImage(source: source);
      setState(() {});
    }
  }
}
