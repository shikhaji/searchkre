import 'package:flutter/material.dart';
import 'package:search_kare/routs/arguments.dart';
import 'package:search_kare/widget/candidate_bottom_navigation_bar.dart';
import 'apply_job_list_screen.dart';
import 'candidate_home_screen.dart';
import 'candidate_my_profile_screen.dart';

class MainCandidateScreen extends StatefulWidget {
  final SendArguments? arguments;
  const MainCandidateScreen({Key? key, this.arguments}) : super(key: key);

  @override
  State<MainCandidateScreen> createState() => _MainCandidateScreenState();
}

class _MainCandidateScreenState extends State<MainCandidateScreen> {
  @override
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
          bottomNavigationBar: CandidateBottomNavigationBar(
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
        return const CandidateHomeScreen();
      case 1:
        return const ApplyJobListScreen();
      case 2:
        return const CandidateMyProfileScreen();
      default:
    }
    return Container();
  }
}
