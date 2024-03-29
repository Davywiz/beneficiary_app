import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget largeScreen;
  final Widget? mediumScreen;
  final Widget? smallScreen;
  const ResponsiveWidget(
      {required Key key,
      required this.largeScreen,
      this.mediumScreen,
      this.smallScreen})
      : super(key: key);
  static bool isSmallScreen(BuildContext context) {
    return MediaQueryData.fromWindow(WidgetsBinding.instance.window)
            .size
            .width <
        800;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQueryData.fromWindow(WidgetsBinding.instance.window)
            .size
            .width >
        1000;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                .size
                .width >=
            800 &&
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width <=
            1000;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return largeScreen;
        } else if (constraints.maxWidth <= 1200 &&
            constraints.maxWidth >= 800) {
          return mediumScreen ?? largeScreen;
        } else {
          return smallScreen ?? largeScreen;
        }
      },
    );
  }
}
