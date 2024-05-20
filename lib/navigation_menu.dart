import 'package:artbox/main_screens/generate_tattoo_screen.dart';
import 'package:artbox/main_screens/home_screen.dart';
import 'package:artbox/main_screens/profile_screen.dart';
import 'package:artbox/membership_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          elevation: 34,
          backgroundColor: Colors.black,
          shadowColor: Colors.black,
          indicatorColor: Colors.blueGrey.shade900,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.flash_1), label: 'AI'),
            NavigationDestination(icon: Icon(Iconsax.heart), label: 'Search'),
            NavigationDestination(icon: Icon(Iconsax.profile_circle4), label: 'Profile'),
          ],

        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController{
  var selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    TattooGenerationScreen(),
    MembershipScreen(),
    const ProfileScreen(),
  ];
  void navigateToAI() {
    selectedIndex.value = 1; // This will navigate to the AI tab
  }
}
