import 'package:artbox/navigation_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    // Store user information in Firestore
    await storeUserData(userCredential.user);

    return userCredential;
  }

  Future<void> storeUserData(User? user) async {
    if (user != null) {
      final usersCollection = FirebaseFirestore.instance.collection('Users');
      await usersCollection.doc(user.uid).set({
        'name': user.displayName,
        'email': user.email,
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0D1B2A) , Color(0xFF000000)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Login form
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.12),
                  Text(
                    'ArtBot',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                  SizedBox(height: 60),
                  Image.asset('assets/demo_tattoo/mangirl.png'),
                  SizedBox(height: 20),
                  Text(
                    "Find Your Tattoo",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 100),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(

                        elevation: 10,
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // Border radius
                        ),
                      ),
                        onPressed: () async {
                          try {
                            UserCredential userCredential = await signInWithGoogle();
                            // Navigate to the NavigationMenuScreen on successful login
                            Get.offAll(() => const NavigationMenu());
                          } catch (e) {
                            // Show error snackbar if login fails
                            print(e);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error during Google sign-in: $e'),
                              ),
                            );
                          }
                        },
                      child: Text('Login/Sign up with Google'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
