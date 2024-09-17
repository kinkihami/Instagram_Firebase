import 'package:flutter/material.dart';
import 'package:instagram_project/Screen/auth/auth.dart';
import 'package:instagram_project/Screen/chat.dart';
// import 'package:instagram_project/Screen/profile/edit_profile.dart';
import 'package:instagram_project/Screen/Nav_bar/home.dart';
import 'package:instagram_project/Screen/like_notification.dart';
import 'package:instagram_project/Screen/auth/login.dart';
import 'package:instagram_project/Screen/Nav_bar/navigation_bar.dart';
import 'package:instagram_project/Screen/Nav_bar/profile.dart';
import 'package:instagram_project/Screen/Nav_bar/reels.dart';
import 'package:instagram_project/Screen/Nav_bar/search.dart';
import 'package:instagram_project/Screen/auth/signup/SignUp.dart';
import 'package:instagram_project/Screen/auth/signup/Details.dart';
import 'package:instagram_project/Screen/profile/settings.dart';
import 'package:instagram_project/splash.dart';
import 'package:instagram_project/Screen/user.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => const ScreenSplash(),
  '/auth': (context) => const AuthPage(),
  '/login': (context) => const ScreenLogin(),
  '/details': (context) => const ScreenDetails(),
  '/signup': (context) => const ScreenSignUp(),
  // '/phone_email': (context) => const ScreenPhoneEmail(),
  '/home': (context) => const ScreenHome(),
  '/settings': (context) => const ScreenSettings(),
  '/search': (context) => const ScreenSearch(),
  '/chat': (context) => const ScreenChat(),
  '/reels': (context) => const ScreenReels(),
  '/profile': (context) => const ScreenProfile(),
  // '/editprofile': (context) => const ScreenEditProfile(),
  '/like_notification': (context) => const ScreenLike(),
  '/user': (context) => const ScreenUserPage(),
  '/nav_bar': (context) => const MyBottomNavigationBar(),
};
