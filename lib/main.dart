import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:instagram_project/Screen/auth/firebase_options.dart';
import 'package:instagram_project/constant/colors.dart';
import 'package:instagram_project/routes/route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Instagram Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: routes,
      theme: ThemeData(
          fontFamily: 'Helvetica Neue',
          primaryColor: blue,
          textSelectionTheme: TextSelectionThemeData(cursorColor: blue)),
    );
  }
}
