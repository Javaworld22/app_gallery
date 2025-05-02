import 'package:assess_gallery/route/route_constants.dart';
import 'package:flutter/material.dart';

import '../views/home/home_screen.dart';

// Yuo will get 50+ screens and more once you have the full template
// 🔗 Full template: https://theflutterway.gumroad.com/l/fluttershop


Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case homePage:
      return MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );
    default:
      return MaterialPageRoute(
        // Make a screen for undefine
        builder: (context) => const HomeScreen(),
      );
  }
}
