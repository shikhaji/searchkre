import 'package:flutter/material.dart';
import 'package:search_kare/utils/app_color.dart';

class CircleIconButton extends StatelessWidget {
  final Color? color;
  final Color? backgroundColor;
  final Widget child;
  final double? size;
  final BoxBorder? border;
  final VoidCallback onPressed;
  final List<BoxShadow>? boxShadow;

  CircleIconButton({
    super.key,
    required Widget child,
    EdgeInsets? padding,
    required this.onPressed,
    this.backgroundColor,
    this.color,
    this.boxShadow,
    this.size,
    this.border,
  }) : child = Padding(
          padding: padding ?? EdgeInsets.zero,
          child: child,
        );

  CircleIconButton.icon({
    super.key,
    required IconData icon,
    double? iconSize,
    required this.onPressed,
    this.backgroundColor,
    this.color,
    this.boxShadow,
    this.size,
    this.border,
  }) : child = Icon(icon, size: iconSize, color: color);

  @override
  Widget build(BuildContext context) {
    Color tapEffectColor = color ?? Colors.grey;
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor ?? AppColor.textFieldColor,
        boxShadow: boxShadow,
        border: border,
      ),
      child: MaterialButton(
        color: backgroundColor,
        shape: const CircleBorder(),
        elevation: 0,
        highlightElevation: 0,
        disabledElevation: 0,
        height: size ?? 46,
        minWidth: size ?? 46,
        padding: EdgeInsets.zero,
        splashColor: tapEffectColor.withOpacity(0.1),
        highlightColor: tapEffectColor.withOpacity(0.1),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
