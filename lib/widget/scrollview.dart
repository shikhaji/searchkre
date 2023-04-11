import 'package:flutter/cupertino.dart';
import 'package:search_kare/widget/primary_padding.dart';

class CustomScroll extends StatelessWidget {
  final List<Widget> children;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final ScrollPhysics physics;

  const CustomScroll({
    Key? key,
    required this.children,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.physics = const AlwaysScrollableScrollPhysics(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PrimaryPadding(
        child: SingleChildScrollView(
          physics: physics,
          child: Column(
            crossAxisAlignment: crossAxisAlignment,
            mainAxisAlignment: mainAxisAlignment,
            children: children,
          ),
        ),
      ),
    );
  }
}
