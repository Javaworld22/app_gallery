import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:image_picker/image_picker.dart';

import '../../controller/home_controller.dart';
import '../../theme/button_them.dart';
import '../../util/constants.dart';
import '../../util/my_dialog.dart';
import '../../util/responsive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> with  TickerProviderStateMixin{
  AnimationController? bottomSheetcontroller;

  @override
  void initState() {
    bottomSheetcontroller = BottomSheet.createAnimationController(this);
    bottomSheetcontroller?.duration = const Duration(milliseconds: 400);
    bottomSheetcontroller?.reverseDuration = const Duration(milliseconds: 400);
    bottomSheetcontroller?.drive(CurveTween(curve: Curves.easeIn));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery
        .of(context)
        .size;
    return GetX<HomeController>(
        init: HomeController(),
    builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 0,
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent, // Transparent status bar
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness
                .dark, // Dark text for status bar
          ),
        ),

        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: DottedBorder(
                      radius: const Radius.circular(12),
                      child: ClipRRect(
                        child: SizedBox(
                          height: 600,
                          width: size.width,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              controller.imageSelected.value ?
                              SizedBox(
                                width: (size.width-(28*2)-6), //351,
                                height: 600,
                                child: ClipRRect(
                                  child: Image.file(
                                    File(controller.nImage.value),
                                    // width: 311,
                                    // height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ):
                          Text('${controller.imagePreview}',
                          style: TextStyle(
                            fontSize: 26,
                            color: Colors.grey,
                          ),),
                            ],
                          ),
                        ),
                      )
                  ),
                ),
                Visibility(
                  visible: controller.imageSelected.value,
                  child: Text('File Size: ${controller.fileSize.value.toStringAsFixed(2)}kb'),
        ),
                SizedBox(height: 30,),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ButtonThem.buildIconButton(context,
                      btnWidthRatio: 110,
                      color: photo,
                      btnRadius: 12.0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: Responsive.width(25, context),
                            height: Responsive.height(25, context),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              iconSize: 25,
                              onPressed: () async {},
                              color: const Color(0xff0a0a0a),
                              icon: const Icon(Icons.camera_enhance, size: 25,
                                color: Colors.white,),
                            ),
                          ),
                          SizedBox(width: 2,),
                          Text('photo',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      onPress: () {
                        controller.pickFile(
                            source: ImageSource.camera, type: 'front');
                      },),
                    ButtonThem.buildIconButton(context,
                      btnWidthRatio: 110,
                      color: gallery,
                      btnRadius: 12.0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: Responsive.width(25, context),
                            height: Responsive.height(25, context),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              // alignment: Alignment.center,
                              iconSize: 25,
                              onPressed: () async {},
                              color: const Color(0xff0a0a0a),
                              icon: const Icon(
                                Icons.upload_file_rounded, size: 25,
                                color: Colors.white,),
                            ),
                          ),
                          SizedBox(width: 2,),
                          Text('Gallery', // Take a photo  Upload Image
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      onPress: () {
                        controller.pickFile(
                            source: ImageSource.gallery, type: 'front');
                      },),
                    ButtonThem.buildIconButton(context,
                      btnWidthRatio: 110,
                      color: errorColor,
                      btnRadius: 12.0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: Responsive.width(25, context),
                            height: Responsive.height(25, context),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              // alignment: Alignment.center,
                              iconSize: 25,
                              onPressed: () async {},
                              color: const Color(0xff0a0a0a),
                              icon: const Icon(
                                Icons.delete_outlined, size: 25,
                                color: Colors.white,),
                            ),
                          ),
                          SizedBox(width: 2,),
                          Text('Delete', // Take a photo  Upload Image
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      onPress: () {
                      if(!controller.imageSelected.value){
                        Get.closeAllSnackbars();
                        MyDialogs.info(msg: 'Picture already deleted');
                      }else if(controller.imageSelected.value){
                        controller.imageSelected.value = false;
                        Get.closeAllSnackbars();
                        MyDialogs.success(msg: 'Picture deleted');
                      }
                      },),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
    );
  }

}