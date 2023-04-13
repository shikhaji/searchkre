import 'package:flutter/material.dart';
import 'package:search_kare/routs/arguments.dart';
import 'package:search_kare/views/companyDashboard/post_job_screen.dart';
import 'package:search_kare/widget/company_bottom_navigation_bar.dart';
import 'company_home_screen.dart';
import 'company_my_profile_screen.dart';

class MainCompanyScreen extends StatefulWidget {
  final SendArguments? arguments;
  const MainCompanyScreen({Key? key, this.arguments}) : super(key: key);

  @override
  State<MainCompanyScreen> createState() => _MainCompanyScreenState();
}

class _MainCompanyScreenState extends State<MainCompanyScreen> {
  final ValueNotifier<int> _currentIndexNotifier = ValueNotifier(0);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    if (widget.arguments!.bottomIndex != 0) {
      _currentIndexNotifier.value = widget.arguments!.bottomIndex!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _currentIndexNotifier,
      builder: (context, currentIndex, child) {
        return Scaffold(
          key: _scaffoldKey,
          body: _buildBody(currentIndex),
          bottomNavigationBar: CompanyBottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              _currentIndexNotifier.value = index;
            },
          ),
        );
      },
    );
  }

  Widget _buildBody(int index) {
    switch (index) {
      case 0:
        return const CompanyHomeScreen();
      case 1:
        return const PostJobScreen();
      case 2:
        return const CompanyMyProfileScreen();
      default:
    }
    return Container();
  }
}
