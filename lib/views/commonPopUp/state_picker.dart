import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_kare/models/get_state_list_model.dart';
import 'package:search_kare/models/state_model.dart';
import 'package:search_kare/services/api_services.dart';
import 'package:search_kare/utils/app_color.dart';
import 'package:search_kare/utils/app_sizes.dart';
import 'package:search_kare/widget/app_text_field.dart';
import 'package:search_kare/widget/custom_sized_box.dart';

class StatePickerPopup extends StatefulWidget {
  const StatePickerPopup({super.key});

  static Future<StateModel> show(BuildContext context) async {
    return await showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => const StatePickerPopup(),
    );
  }

  @override
  State<StatePickerPopup> createState() => _StatePickerPopupState();
}

class _StatePickerPopupState extends State<StatePickerPopup> {
  final TextEditingController _searchController = TextEditingController();

  bool _isSearching = false;
  List<StateModel> _stateResponse = [];
  List<StateModel> _state = [];

  @override
  void initState() {
    super.initState();
    fetchState();
  }

  Future<void> fetchState() async {
    GetStateListModel? response = await ApiService().getState();
    if (response != null) {
      _state =
          response.message.map((e) => StateModel.fromJson(e.toJson())).toList();
      _stateResponse =
          response.message.map((e) => StateModel.fromJson(e.toJson())).toList();
      setState(() {});
    }
  }

  Future<void> _onSearchHandler(String data) async {
    if (data.isNotEmpty) {
      _isSearching = true;
      _state = _isSearching ? searchState(data) : _state;
    } else {
      _state.clear();
      _state = _stateResponse;
      _isSearching = false;
    }
    setState(() {});
  }

  List<StateModel> searchState(String data) {
    return _stateResponse
        .where((e) => e.stateName!.toLowerCase().contains(data.toLowerCase()))
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
                          _state.clear();
                          _state = _stateResponse;
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
                  itemCount: _state.length,
                  padding: EdgeInsets.symmetric(
                    horizontal: Sizes.s16.w,
                    vertical: Sizes.s20.h,
                  ),
                  itemBuilder: (context, index) {
                    StateModel state = _state[index];
                    return _StateListTile(
                      stateModel: state,
                      onTap: () {
                        Navigator.pop(context, state);
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

class _StateListTile extends StatelessWidget {
  final StateModel stateModel;
  final VoidCallback onTap;
  const _StateListTile({
    required this.stateModel,
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
                stateModel.stateName ?? '',
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
