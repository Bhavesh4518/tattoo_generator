
import 'package:artbox/app_routes.dart';
import 'package:artbox/auth_screens/login_screen.dart';
import 'package:artbox/main_screens/on_boarding_screen/on_boarding_screen.dart';
import 'package:artbox/navigation_menu.dart';
import 'package:artbox/repositories/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'firebase_options.dart';



Future<void> main() async {

  final WidgetsBinding widgetsBinding =
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((FirebaseApp value) => Get.put(AuthenticationRepository()));
  runApp(const MyApp());

}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black, // Background color
      statusBarColor: Colors.transparent, // Status bar color
    ));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          useMaterial3: true,
        ),
        getPages: AppRoutes.pages(),
        home: const Scaffold(backgroundColor: Colors.black,
          body: Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),),
    );
  }
}

