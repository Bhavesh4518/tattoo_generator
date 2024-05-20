

import 'package:artbox/main_screens/generate_tattoo_screen.dart';
import 'package:artbox/membership_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import 'main_screens/home_screen.dart';

class AppRoutes {
  static List<GetPage> pages() {

    return [
      GetPage(name: MyRoutes.home, page: () =>  HomeScreen()),
      GetPage(name: MyRoutes.tattooGeneration, page: () => TattooGenerationScreen()),
      GetPage(name: MyRoutes.membershipScreen, page: () => MembershipScreen()),
    //  GetPage(name: MyRoutes.profile, page: () => const AddExpenseScreen(title: '')),
    ];
  }
}

class MyRoutes {
  static const home = '/home';
  static const tattooGeneration = '/tattooGenerationScreen';
  static const profile = '/profile';
  static const membershipScreen = '/membershipScreen';

}
