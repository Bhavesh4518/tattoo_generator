import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../auth_screens/login_screen.dart';
import '../main_screens/on_boarding_screen/on_boarding_screen.dart';
import '../navigation_menu.dart';
import 'my_local_storage.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  // Get authenticated User data
  User? get authUser => _auth.currentUser;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
    super.onReady();
  }

  Future<void> screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null && user.providerData.any((userInfo) => userInfo.providerId == 'google.com')) {
      /// Initialize user-specific storage
      await MyLocalStorage.init(user.uid);
      Get.offAll(() => const NavigationMenu());
    } else {
      // Local Storage
      deviceStorage.writeIfNull('isFirstTime', true);
      deviceStorage.read('isFirstTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(() => OnBoardingScreen());
    }
  }
}
