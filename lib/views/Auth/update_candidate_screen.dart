import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:search_kare/models/city_model.dart';
import 'package:search_kare/models/state_model.dart';
import 'package:search_kare/routs/arguments.dart';
import 'package:search_kare/services/api_services.dart';
import 'package:search_kare/utils/app_asset.dart';
import 'package:search_kare/utils/app_color.dart';
import 'package:search_kare/utils/app_sizes.dart';
import 'package:search_kare/utils/app_text.dart';
import 'package:search_kare/utils/app_text_style.dart';
import 'package:file_picker/file_picker.dart';
import 'package:search_kare/utils/file_utils.dart';
import 'package:search_kare/utils/screen_utils.dart';
import 'package:search_kare/utils/show_toast.dart';
import 'package:search_kare/utils/validation_mixin.dart';
import 'package:search_kare/views/commonPopUp/city_picker.dart';
import 'package:search_kare/views/commonPopUp/state_picker.dart';
import 'package:search_kare/widget/app_bars.dart';
import 'package:search_kare/widget/app_button.dart';
import 'package:search_kare/widget/custom_sized_box.dart';
import 'package:search_kare/widget/app_text_field.dart';
import 'package:search_kare/widget/scrollview.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';

class UpdateCandidateScreen extends StatefulWidget {
  final SendArguments? arguments;
  const UpdateCandidateScreen({Key? key, this.arguments}) : super(key: key);

  @override
  State<UpdateCandidateScreen> createState() => _UpdateCandidateScreenState();
}

class _UpdateCandidateScreenState extends State<UpdateCandidateScreen>
    with ValidationMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _fName = TextEditingController();
  final TextEditingController _mName = TextEditingController();
  final TextEditingController _email = TextEditingController();
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

  StateModel stateModel = StateModel();
  CityModel cityModel = CityModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(
        context,
        title: "Candidate",
      ),
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: CustomScroll(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBoxH46(),
            appText("Update Profile", style: AppTextStyle.s26W7Black),
            SizedBoxH6(),
            appText(
              "Please update your profile and continue",
              style:
                  AppTextStyle.whiteSubtitle.copyWith(color: AppColor.darkGrey),
            ),
            SizedBoxH28(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
            AppTextField(
              title: "Mobile Number",
              controller:
                  TextEditingController(text: widget.arguments?.mobileNumber),
              hintText: "Enter your mobile number",
              validator: mobileNumberValidator,
              readOnly: true,
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
            InkWell(
              onTap: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['pdf'],
                    allowMultiple: false);
                if (result == null) return;
                final path = result.files.single.path;

                setState(() => _file = File(path!));
              },
              child: uploadBox(
                'Upload Your CV',
                _file != null ? _file!.path : '',
              ),
            ),
            SizedBoxH28(),
            AppButton(
                title: "Update",
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    if (_formKey.currentState?.validate() ?? false) {
                      if (selectedDocument!.path == null) {
                        showToast("Upload profile image");
                      } else if (_file!.path == null) {
                        showToast("Upload CV document");
                      } else {
                        var profileImage = await MultipartFile.fromFile(
                            selectedDocument!.path);
                        var cv = await MultipartFile.fromFile(_file!.path);
                        FormData data() {
                          return FormData.fromMap({
                            "loginid": widget.arguments?.kycLoginId,
                            "profile_type": 2,
                            'name': _name.text.trim(),
                            "father_name": _fName.text.trim(),
                            "mother_name": _mName.text.trim(),
                            "phone": widget.arguments?.mobileNumber,
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

                        ApiService().updateCandidate(context, 0, data: data());
                      }
                    }
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
      child: Center(
        child: image != ''
            ? ListTile(
                title: Text(
                  image != "" ? image.split("/").last : "",
                  style: AppTextStyle.appText.copyWith(fontSize: Sizes.s12),
                ),
                leading: const Icon(
                  Icons.picture_as_pdf,
                  color: Colors.red,
                ),
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.upload_file),
                  Text("Upload Your CV")
                ],
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
