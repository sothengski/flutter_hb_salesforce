import 'package:flutter/material.dart';

/// Layout breakpoints used in the app.
class Breakpoints {
  static const double mobile = 600;
  static const double tablet = 900;
  static const double desktop = 1200;
}

class Sizing {
  static double font(BuildContext context, double mobile) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < Breakpoints.mobile) return mobile;
    if (width < Breakpoints.tablet) return mobile * 1.2;
    return mobile * 1.4;
  }

  static double spacing(BuildContext context, double mobile) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < Breakpoints.mobile) return mobile;
    if (width < Breakpoints.tablet) return mobile * 1.5;
    return mobile * 2;
  }
}
