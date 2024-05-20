import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../main_screens/try_out_screen.dart';

class TattooCard extends StatelessWidget {

  final String? image;
  final String? name;

  const TattooCard({
    super.key,
    this.image,
    this.name,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2C2C2C), // Dark gray
            Color(0xFF1F1F1F), // Darker gray
            Color(0xFF141414), // Even darker gray
            Color(0xFF0A0A0A), // Almost black
          ],
        ),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (image != null)
                Image.network(
                  image!,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              const SizedBox(height: 8),
              Text(name ?? 'Artbot tattoo', style: TextStyle(color: Colors.white)),
            ],
          ),
          Positioned(
            top: -10,
            right: -5,
            child: IconButton(
              icon: const Icon(Iconsax.heart, color: Colors.white24,size: 21),
              onPressed: () {
                // Add your onPressed code here!
              },
            ),
          ),
          Positioned(
            bottom: -8,
            right: -10,
            child: TextButton(
              child: const Text('Try it',style: TextStyle(color: Colors.blueGrey,fontSize: 12)),
              onPressed: () {
                Get.to(() => TryoutScreen(tattooImage: image));
              },
            ),
          ),
        ],
      ),
    );
  }
}
