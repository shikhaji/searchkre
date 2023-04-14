import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_kare/models/business_category.dart';
import 'package:search_kare/models/business_category_list.dart';
import 'package:search_kare/services/api_services.dart';
import 'package:search_kare/utils/app_color.dart';
import 'package:search_kare/utils/app_sizes.dart';
import 'package:search_kare/widget/app_text_field.dart';
import 'package:search_kare/widget/custom_sized_box.dart';

class BusinessCategoryPickerPopup extends StatefulWidget {
  const BusinessCategoryPickerPopup({super.key});

  static Future<BusinessCategory> show(BuildContext context) async {
    return await showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => const BusinessCategoryPickerPopup(),
    );
  }

  @override
  State<BusinessCategoryPickerPopup> createState() =>
      _BusinessCategoryPickerPopupState();
}

class _BusinessCategoryPickerPopupState
    extends State<BusinessCategoryPickerPopup> {
  final TextEditingController _searchController = TextEditingController();

  bool _isSearching = false;
  List<BusinessCategory> _categoryResponse = [];
  List<BusinessCategory> _category = [];

  @override
  void initState() {
    super.initState();
    fetchState();
  }

  Future<void> fetchState() async {
    BusinessCategoryList? response = await ApiService().businessCategoryList();
    if (response != null) {
      _category = response.message
          .map((e) => BusinessCategory.fromJson(e.toJson()))
          .toList();
      _categoryResponse = response.message
          .map((e) => BusinessCategory.fromJson(e.toJson()))
          .toList();
      setState(() {});
    }
  }

  Future<void> _onSearchHandler(String data) async {
    if (data.isNotEmpty) {
      _isSearching = true;
      _category = _isSearching ? searchState(data) : _category;
    } else {
      _category.clear();
      _category = _categoryResponse;
      _isSearching = false;
    }
    setState(() {});
  }

  List<BusinessCategory> searchState(String data) {
    return _categoryResponse
        .where((e) => e.brandName!.toLowerCase().contains(data.toLowerCase()))
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
                          _category.clear();
                          _category = _categoryResponse;
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
                  itemCount: _category.length,
                  padding: EdgeInsets.symmetric(
                    horizontal: Sizes.s16.w,
                    vertical: Sizes.s20.h,
                  ),
                  itemBuilder: (context, index) {
                    BusinessCategory category = _category[index];
                    return _BusinessCategoryListTile(
                      businessCategory: category,
                      onTap: () {
                        Navigator.pop(context, category);
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

class _BusinessCategoryListTile extends StatelessWidget {
  final BusinessCategory businessCategory;
  final VoidCallback onTap;
  const _BusinessCategoryListTile({
    required this.businessCategory,
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
                businessCategory.brandName ?? '',
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
