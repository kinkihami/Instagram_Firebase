import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_project/constant/colors.dart';
import 'package:instagram_project/constant/sizedbox.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenDetails extends StatefulWidget {
  const ScreenDetails({super.key});

  @override
  State<ScreenDetails> createState() => _ScreenDetailsState();
}

class _ScreenDetailsState extends State<ScreenDetails> {
  bool _button = false;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    _usernameController.addListener(_onTextChanged);
    _phoneController.addListener(_onTextChanged);
    super.initState();
  }

  void _onTextChanged() {
    setState(() {
      _button = _usernameController.text.isNotEmpty &&
          _phoneController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        toolbarHeight: 30,
        backgroundColor: black,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: white,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Text(
              'Profile information',
              style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.bold, color: white),
            ),
            height10,
            Text(
              'Please provide your phone number and choose a username',
              textAlign: TextAlign.center,
              style: TextStyle(color: grey, fontSize: 12),
            ),
            height20,
            SizedBox(
              height: 40,
              child: TextFormField(
                controller: _usernameController,
                autofocus: true,
                style: TextStyle(color: white, fontSize: 12),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 10),
                  hintText: 'Username',
                  hintStyle: TextStyle(color: grey, fontSize: 12),
                  filled: true,
                  fillColor: darkgrey,
                  suffixIcon: _usernameController.text.isEmpty
                      ? null
                      : IconButton(
                          onPressed: () {
                            _usernameController.clear();
                          },
                          icon: CircleAvatar(
                            radius: 8,
                            backgroundColor: grey,
                            child: Icon(
                              Icons.clear,
                              size: 10,
                              color: black,
                            ),
                          )),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: grey, width: 0.1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: grey, width: 0.1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            height10,
            SizedBox(
              height: 40,
              child: TextFormField(
                keyboardType: TextInputType.phone,
                controller: _phoneController,
                style: TextStyle(color: white, fontSize: 12),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 10),
                  hintText: 'Phone number',
                  hintStyle: TextStyle(color: grey, fontSize: 12),
                  filled: true,
                  fillColor: darkgrey,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: grey, width: 0.1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  suffixIcon: _phoneController.text.isEmpty
                      ? null
                      : IconButton(
                          onPressed: () {
                            _phoneController.clear();
                          },
                          icon: CircleAvatar(
                            radius: 8,
                            backgroundColor: grey,
                            child: Icon(
                              Icons.clear,
                              size: 10,
                              color: black,
                            ),
                          )),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: grey, width: 0.1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            height20,
            GestureDetector(
              onTap: () => _button ? _createAcc() : null,
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: _button ? blue : blue.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    'Next',
                    style: TextStyle(
                        color: _button ? white : white.withOpacity(0.7),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _createAcc() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString('email');
      final password = prefs.getString('password');

      log(email!);
      log(password!);

      // Create user account
      final authResult =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final uid = authResult.user?.uid;
      log(uid.toString());
      if (uid == null) {
        // Handle the case where user creation failed
        return;
      }

      // Add user details to Firestore
      try {
        await FirebaseFirestore.instance.collection('Users').doc(uid).set({
          'Username': _usernameController.text,
          'Email': email,
          'Password': password,
          'Phone': _phoneController.text,
          'Followers': [],
          'Following': [],
          'uid': uid,
          'bio': '',
          'profile': 'assets/images/blank-profile-picture-973460_1280.png',
        });
      } catch (e) {
        // Handle any errors
        print("Error adding user details: $e");
      }

      Navigator.pushNamedAndRemoveUntil(context, '/nav_bar', (route) => false);
    } catch (e) {
      // Handle any errors
      print("Error creating account: $e");
    }
  }

  void showError() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text(
        '   Username already exist',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: red,
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      duration: const Duration(seconds: 3),
    ));
  }
}
