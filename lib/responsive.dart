import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;
  const Responsive({
    Key? key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  }) : super(key: key);

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1150;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width < 1150 &&
        MediaQuery.of(context).size.width >= 710;
  }

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 710;
  }

  @override
  Widget build(BuildContext context) {
    if (isDesktop(context)) return desktop;
    if (isTablet(context) && tablet != null) return tablet!;
    return mobile;
  }
}
