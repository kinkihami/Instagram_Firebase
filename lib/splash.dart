import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram_project/constant/colors.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    load();
    super.initState();
  }

  Future<void> load() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    Navigator.pushReplacementNamed(context, '/auth');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: black,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/vecteezy_instagram-logo-png-instagram-icon-transparent_18930691.png',
                height: 135,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'from',
                    style: TextStyle(color: grey),
                  ),
                  Image.asset(
                    'assets/images/Instagram-Meta-Logo-PNG-1.png',
                    height: 35,
                  )
                ],
              ),
            )
          ],
        ));
  }
}
