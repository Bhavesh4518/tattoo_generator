import 'package:artbox/auth_screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  Future<void> _signOut() async {
    try {
      final googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => LoginScreen()); // Navigate to login screen
    } catch (e) {
      print('Error signing out: $e');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24,kToolbarHeight * 1.2, 24,12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user?.displayName ?? "N/A",
              style: const TextStyle(fontSize: 18,color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              user?.email ?? "N/A",
              style: const TextStyle(fontSize: 18,color: Colors.white),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed : _signOut,
              child: Center(child: const Text('Sign Out')),
            ),
          ],
        ),
      ),
    );
  }
}
