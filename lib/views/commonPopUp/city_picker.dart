import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_kare/models/city_model.dart';
import 'package:search_kare/models/get_city_list_model.dart';
import 'package:search_kare/services/api_services.dart';
import 'package:search_kare/utils/app_color.dart';
import 'package:search_kare/utils/app_sizes.dart';
import 'package:search_kare/widget/app_text_field.dart';
import 'package:search_kare/widget/custom_sized_box.dart';

class CityPickerPopup extends StatefulWidget {
  final String stateId;
  const CityPickerPopup({
    super.key,
    required this.stateId,
  });

  static Future<CityModel> show(BuildContext context, String stateId) async {
    return await showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => CityPickerPopup(stateId: stateId),
    );
  }

  @override
  State<CityPickerPopup> createState() => _CityPickerPopupState();
}

class _CityPickerPopupState extends State<CityPickerPopup> {
  final TextEditingController _searchController = TextEditingController();

  bool _isSearching = false;

  List<CityModel> _city = [];
  List<CityModel> _cityResponse = [];

  @override
  void initState() {
    super.initState();
    fetchState();
  }

  Future<void> fetchState() async {
    GetCityListModel? response = await ApiService().getCity(widget.stateId);
    if (response != null) {
      _city =
          response.message.map((e) => CityModel.fromJson(e.toJson())).toList();
      _cityResponse =
          response.message.map((e) => CityModel.fromJson(e.toJson())).toList();
      setState(() {});
    } else {}
  }

  Future<void> _onSearchHandler(String data) async {
    if (data.isNotEmpty) {
      _isSearching = true;
      _city = _isSearching ? searchCity(data) : _city;
    } else {
      _city.clear();
      _city = _cityResponse;
      _isSearching = false;
    }
    setState(() {});
  }

  List<CityModel> searchCity(String data) {
    return _cityResponse
        .where(
            (e) => e.districtName!.toLowerCase().contains(data.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Dialog(
        insetPadding: EdgeInsets.all(Sizes.s20.h),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.s12.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.s14.w,
            vertical: Sizes.s20.h,
          ),
          child: Column(
            children: [
              AppTextField(
                title: '',
                controller: _searchController,
                onChanged: _onSearchHandler,
                hintText: 'Search State',
                color: AppColor.textFieldColor,
                suffix: _isSearching
                    ? InkWell(
                        onTap: () {
                          _searchController.clear();
                          _isSearching = false;
                          _city.clear();
                          _city = _cityResponse;
                          setState(() {});
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.clear,
                            color: Colors.black,
                          ),
                        ),
                      )
                    : null,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _city.length,
                  padding: EdgeInsets.symmetric(
                    horizontal: Sizes.s16.w,
                    vertical: Sizes.s20.h,
                  ),
                  itemBuilder: (context, index) {
                    CityModel cityModel = _city[index];
                    return _CityListTile(
                      cityModel: cityModel,
                      onTap: () {
                        Navigator.pop(context, cityModel);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CityListTile extends StatelessWidget {
  final CityModel cityModel;
  final VoidCallback onTap;
  const _CityListTile({
    required this.cityModel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBoxH8(),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  horizontal: Sizes.s12.h, vertical: Sizes.s18.h),
              decoration: BoxDecoration(
                  color: AppColor.textFieldColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                cityModel.districtName ?? '',
                style: TextStyle(
                  fontSize: Sizes.s16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ));
  }
}
