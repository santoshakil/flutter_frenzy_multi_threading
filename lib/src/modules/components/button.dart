import 'package:flutter/material.dart';

class CustomeMaterialButton extends StatelessWidget {
  const CustomeMaterialButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
    this.padding,
    this.margin,
    this.w,
    this.h,
  });
  final VoidCallback onPressed;
  final Widget child;
  final EdgeInsetsGeometry? padding, margin;
  final double? w, h;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: w,
      height: h,
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: MaterialButton(
          elevation: 0,
          highlightElevation: 0,
          color: backgroundColor,
          highlightColor: backgroundColor,
          hoverElevation: 0,
          splashColor: backgroundColor!.withOpacity(.3),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: padding,
          onPressed: onPressed,
          child: child,
        ),
      ),
    );
  }
}
