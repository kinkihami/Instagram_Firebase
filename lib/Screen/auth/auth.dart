import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_project/Screen/auth/login.dart';
import 'package:instagram_project/Screen/Nav_bar/navigation_bar.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              return const MyBottomNavigationBar();
            } else {
              return const ScreenLogin();
            }
          }),
    );
  }
}
