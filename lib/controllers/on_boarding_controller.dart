
import 'package:artbox/navigation_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../auth_screens/login_screen.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  // Update Current Index when page scroll
  void updatePageIndicator(index) => currentPageIndex.value = index;

  // Jump to specific dot selected page
  void dotNavigationClick(index){
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  // Update current index and Jump to next Page
  void nextPage(){
    if(currentPageIndex.value == 2){

      Get.offAll(() => const NavigationMenu());
      final storage = GetStorage();
      storage.write('isFirstTime', false);
      Get.offAll(const LoginScreen());
      /// consider using: "Get.offAll(() => Page())" instead of "Get.offAll(Page())".
    }
    else{
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  // Update Current index and jump to the last page
  void skipPage(){
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
  }

}