import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';

import '../controllers/try_out_controller.dart';

class TryoutScreen extends StatelessWidget {
  final String? tattooImage;

  TryoutScreen({Key? key, this.tattooImage}) : super(key: key);

  final TryoutController controller = Get.put(TryoutController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Tryout Tattoo',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Obx(() {
            if (controller.selectedImage.value != null) {
              return Expanded(
                child: Stack(
                  children: [
                    RepaintBoundary(
                      key: controller.screenshotKey,
                      child: Stack(
                        children: [
                          PhotoView(
                            imageProvider: FileImage(controller.selectedImage.value!),
                          ),
                          if (tattooImage != null)
                            Obx(() {
                              return Positioned(
                                top: controller.tattooPosition.value.dy,
                                left: controller.tattooPosition.value.dx,
                                child: GestureDetector(
                                  onScaleStart: (details) {
                                    controller.initialFocalPoint.value = details.focalPoint;
                                  },
                                  onScaleUpdate: (details) {
                                    controller.updateScale(details.scale);
                                    controller.updateRotation(details.rotation);
                                    controller.updatePosition(
                                        details.focalPoint - controller.initialFocalPoint.value);
                                    controller.initialFocalPoint.value = details.focalPoint;
                                  },
                                  child: Transform(
                                    transform: Matrix4.identity()
                                      ..scale(controller.tattooScale.value)
                                      ..rotateZ(controller.tattooRotation.value),
                                    child: Image.network(tattooImage!),
                                  ),
                                ),
                              );
                            }),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: Row(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: controller.saveImage,
                            child: const Text('Save'),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: controller.clearImage,
                            child: const Text('Remove'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Expanded(
                child: Center(
                  child: Text(
                    'No image selected',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              );
            }
          }),
          Obx(() {
            if (controller.selectedImage.value == null) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.black,
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => controller.pickImage(ImageSource.camera),
                      child: const Text('Camera'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.black,
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => controller.pickImage(ImageSource.gallery),
                      child: const Text('Gallery'),
                    ),
                  ],
                ),
              );
            } else {
              return SizedBox.shrink();
            }
          }),
        ],
      ),
    );
  }
}
