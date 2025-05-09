import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fire_base/auth/signup.dart';
import 'package:fire_base/home/bottom_navigation_bar.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const GetMaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }

          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            home:
                snapshot.data != null ? BottomNavigationBarScreen() : Signup(),
          );
        });
  }
}

// Connect
// if i'm logged in --> Home
// if not --> Login

// authStateChanges -- Stream -- Asynchronous

// StreamBuilder - FutureBuilder //
// Loading - CircularProgressIndicator
