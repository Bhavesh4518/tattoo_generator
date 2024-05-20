import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class TryoutController extends GetxController {
  var selectedImage = Rxn<File?>(null);
  final ImagePicker _picker = ImagePicker();
  var tattooScale = 1.0.obs;
  var tattooPosition = Offset(0, 0).obs;
  var initialFocalPoint = Offset(0, 0).obs;
  var tattooRotation = 0.0.obs; // Added rotation angle
  var isImageSelected = false.obs;
  GlobalKey screenshotKey = GlobalKey();

  Future<void> pickImage(ImageSource source) async {
    await _checkPermissions();
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
      isImageSelected.value = true;
    }
  }

  Future<void> _checkPermissions() async {
    var cameraStatus = await Permission.camera.status;
    var storageStatus = await Permission.storage.status;

    if (!cameraStatus.isGranted) {
      await Permission.camera.request();
    }

    if (!storageStatus.isGranted) {
      await Permission.storage.request();
    }
  }

  void updateScale(double scale) {
    tattooScale.value *= scale;
  }

  void updatePosition(Offset position) {
    tattooPosition.value += position;
  }

  void updateRotation(double rotation) {
    tattooRotation.value += rotation;
  }

  void clearImage() {
    selectedImage.value = null;
    tattooScale.value = 1.0;
    tattooPosition.value = Offset.zero;
    tattooRotation.value = 0.0;
    isImageSelected.value = false;
  }

  Future<void> saveImage() async {
    RenderRepaintBoundary boundary =
    screenshotKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    var image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    final directory = (await getApplicationDocumentsDirectory()).path;
    final imgFile = File('$directory/screenshot.png');
    await imgFile.writeAsBytes(pngBytes);

    await ImageGallerySaver.saveFile(imgFile.path);
    Get.snackbar('Success', 'Image saved to gallery');
  }
}
