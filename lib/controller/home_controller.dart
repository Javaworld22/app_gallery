import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../util/my_dialog.dart';

class HomeController extends GetxController{
  final ImagePicker _imagePicker = ImagePicker();
  RxString imagePreview = "Image preview here".obs;
  RxString backImage = "".obs;
  RxString nImage = "".obs;
  Rx<XFile> imageFile = XFile('').obs;
  RxBool imageSelected = false.obs;
  RxString filepath = ''.obs;
  RxDouble fileSize = 0.0.obs;
  RxString type = ''.obs;


  @override
  void onInit() async{
    await requestPermission();
    super.onInit();
  }

  Future pickFile({required ImageSource source, required String type}) async {
    try {
      XFile? image = await _imagePicker.pickImage(source: source);
      if (image == null) return;

      //if (type == "front") {
        nImage.value = image.path;
        imageSelected.value = true;
        imageFile.value = image;
        filepath.value = image.path;
        int mFile = await imageFile.value.length();
        fileSize.value = (mFile/1024);
      Get.closeAllSnackbars();
      MyDialogs.success(msg: 'Successful');
        if (kDebugMode) {
          print(filepath.value);
        }
      // } else {
      //   backImage.value = image.path;
      // }
    } on PlatformException catch (e) {
      Get.closeAllSnackbars();
      MyDialogs.error(msg: "Camera denied ");
      //GalleyToast().showToast(msg: 'Camera denied');
      debugPrint(e.toString());
      debugPrint('Error at camera here');
    }
  }

  Future<void> requestPermission() async {
    //Request storage permission
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }


    // Request forCamera permission
    var cameraStatus = await Permission.camera.request();
    if (!cameraStatus.isGranted) {
      await Permission.camera.request();
    }else if(cameraStatus.isDenied){
      Get.closeAllSnackbars();
      MyDialogs.error(msg: 'Camera permission denied');
    }else if(cameraStatus.isPermanentlyDenied){
      Get.closeAllSnackbars();
        MyDialogs.error(
            msg:
            'Camera permission permanently denied, we cannot request permission');
    }
  }

}