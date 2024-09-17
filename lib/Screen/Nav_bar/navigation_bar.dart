import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_project/Screen/Nav_bar/add_post.dart';
import 'package:instagram_project/Screen/Nav_bar/home.dart';
import 'package:instagram_project/Screen/Nav_bar/profile.dart';
import 'package:instagram_project/Screen/Nav_bar/reels.dart';
import 'package:instagram_project/Screen/Nav_bar/search.dart';
import 'package:instagram_project/constant/colors.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  String profile = '';

  void fetchProfile() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('Users').doc(uid).get();

    setState(() {
      profile = userDoc.get('profile');
    });
  }

  @override
  void initState() {
    fetchProfile();
    super.initState();
  }

  Color color = Colors.transparent;
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: black,
      bottomNavigationBar: SizedBox(
        height: 45,
        child: Theme(
          data: Theme.of(context).copyWith(
            highlightColor: color,
            splashColor: color,
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            iconSize: 26,
            backgroundColor: black,
            selectedItemColor: white,
            showSelectedLabels: false,
            unselectedItemColor: white,
            selectedFontSize: 0,
            unselectedFontSize: 0,
            currentIndex: _currentIndex,
            onTap: (value) {
              setState(() {
                _currentIndex = value;
              });
            },
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                  icon: _currentIndex == 0
                      ? Image.asset(
                          'assets/images/fluent--home-32-filled.png',
                          height: 25,
                        )
                      : Image.asset(
                          'assets/images/fluent--home-32-regular.png',
                          height: 25,
                        ),
                  label: 'home'),
              BottomNavigationBarItem(
                  icon: _currentIndex == 1
                      ? Image.asset(
                          'assets/images/iconamoon--search-light (3).png',
                          height: 25,
                        )
                      : Image.asset(
                          'assets/images/iconamoon--search-light (1).png',
                          height: 25,
                        ),
                  label: 'search'),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/basil--add-outline.png',
                    height: 28,
                  ),
                  label: 'add'),
              BottomNavigationBarItem(
                  icon: _currentIndex == 3
                      ? Image.asset(
                          'assets/images/icons8-instagram-reels-50 (1).png',
                          height: 25,
                        )
                      : Image.asset(
                          'assets/images/icons8-instagram-reels-50.png',
                          height: 25,
                        ),
                  label: 'reels'),
              BottomNavigationBarItem(
                  icon: CircleAvatar(
                    backgroundImage: FileImage(File(profile)),
                    radius: 13,
                  ),
                  label: 'profile'),
            ],
          ),
        ),
      ),
      body: _pages.elementAt(_currentIndex),
    );
  }

  static const List<Widget> _pages = <Widget>[
    ScreenHome(),
    ScreenSearch(),
    ScreenAdd(),
    ScreenReels(),
    ScreenProfile(),
  ];
}
