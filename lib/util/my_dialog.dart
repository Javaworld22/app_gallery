import 'package:assess_gallery/util/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../main.dart';

class MyDialogs {
  static success({required String msg}) {
    Get.snackbar('Success', msg,
        colorText: Colors.white, backgroundColor: Colors.green.withOpacity(.9), duration: const Duration(seconds: 2));
  }

  static error({required dynamic msg}) {
    Get.snackbar('Error', msg,
        colorText: Colors.white,
        backgroundColor: Colors.redAccent.withOpacity(.9),duration: const Duration(seconds: 2));
  }

  static info({required String msg}) {
    Get.snackbar('Info', msg, colorText: Colors.white,
        backgroundColor: icon_incomplete.withOpacity(.9),duration: const Duration(seconds: 2));
  }

  static showProgress() {
    Get.dialog(const Center(
        child: CircularProgressIndicator(strokeWidth: 2)));
    //     .whenComplete(() {
    //       print('Completed here');
    //       flag = true;
    // });
  }

  static dismiss(){
    Get.back();
  }
}
