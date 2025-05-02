import 'dart:math';

import 'package:flutter/cupertino.dart';

class Responsive {

  /// For design, 932 is the device heigh
  /// 430 is the device width
  static width(double size, BuildContext context) {
    return ((MediaQuery.of(context).size.width * size)/430) ;
  }

  static height(double size, BuildContext context) {
    return ((MediaQuery.of(context).size.height * size)/932);
  }



  static double textScaleFactor(BuildContext context, {double maxTextScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 932) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }

}
