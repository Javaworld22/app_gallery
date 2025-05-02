import 'package:flutter/material.dart';

import '../util/constants.dart';
import '../util/responsive.dart';

class ButtonThem {
  const ButtonThem({Key? key});


  static buildIconButton(
      BuildContext context, {
        required Widget child,
        double btnHeight = 50,
        double txtSize = 14,
        double btnWidthRatio = 382.0,
        double btnRadius = 53,
        required Function() onPress,
        bool isVisible = true,
        Color? color,
        Color? textColor,
        FontWeight fontWeight = FontWeight.w500,
      }) {
    //final themeChange = Provider.of<DarkThemeProvider>(context);

    return Visibility(
      visible: isVisible,
      child: SizedBox(
        width: Responsive.width(btnWidthRatio, context),
        child: MaterialButton(
          onPressed: onPress,
          height: btnHeight,
          elevation: 0.5,
          shape: RoundedRectangleBorder(
            // side: const BorderSide(width: 1.0,color: AppColors.onBoarding),
            borderRadius: BorderRadius.circular(btnRadius),
          ),
          color: color ?? const Color(0xFF0A0A0A),
          child: child,
        ),
      ),
    );
  }

  static buildBorderButton(
      BuildContext context, {
        required String title,
        double btnHeight = 48,
        double txtSize = 14,
        double btnWidthRatio = 0.9,
        double borderRadius = 100,
        required Function() onPress,
        bool isVisible = true,
        bool iconVisibility = false,
        String iconAssetImage = '',
      }) {
    //final themeChange = Provider.of<DarkThemeProvider>(context);

    return Visibility(
      visible: isVisible,
      child: SizedBox(
        width: Responsive.width(382, context),
        height: btnHeight,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
            foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                side: const BorderSide(width: 1),
              ),
            ),
          ),
          onPressed: onPress,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: iconVisibility,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child:
                  Image.asset(iconAssetImage, fit: BoxFit.cover, width: 32),
                ),
              ),
              Text(
                title.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                 // color: textColor ?? primaryColor,
                  fontSize: txtSize,
                  fontFamily: 'inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
