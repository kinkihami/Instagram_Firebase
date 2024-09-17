import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart%20';
import 'package:get/get.dart';
import 'package:instagram_project/Screen/Nav_bar/profile.dart';
import 'package:instagram_project/constant/colors.dart';
import 'package:instagram_project/constant/sizedbox.dart';

class ScreenSettings extends StatelessWidget {
  const ScreenSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: black,
          title: Text(
            'Settings and activity',
            style: TextStyle(
                color: white, fontWeight: FontWeight.bold, fontSize: 15),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: white,
                size: 20,
              )),
        ),
        backgroundColor: black,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Login',
                style: TextStyle(
                  color: grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              height20,
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Add account',
                  style: TextStyle(
                    color: blue,
                    fontSize: 15,
                  ),
                ),
              ),
              height20,
              GestureDetector(
                onTap: () {
                  profileVariable.dataLoad = false;
                  postVariable.load = false;
                  FirebaseAuth.instance.signOut();
                  Get.offAllNamed('/login');
                },
                child: Text(
                  'Log out',
                  style: TextStyle(color: red, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
