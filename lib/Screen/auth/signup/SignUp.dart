import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart%20';
import 'package:instagram_project/constant/colors.dart';
import 'package:instagram_project/constant/sizedbox.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenSignUp extends StatefulWidget {
  const ScreenSignUp({super.key});

  @override
  State<ScreenSignUp> createState() => _ScreenSignUpState();
}

class _ScreenSignUpState extends State<ScreenSignUp> {
  bool _button = false;
  bool _checkbox = true;
  final _formkey = GlobalKey<FormState>();
  bool _haserror = false;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    _passwordController.addListener(_onTextChanged);
    super.initState();
  }

  void _onTextChanged() {
    setState(() {
      _button = _passwordController.text.isNotEmpty;
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
              'Create an account',
              style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.bold, color: white),
            ),
            height10,
            Text(
              "Create an account by entering your email and password for access to app features.",
              textAlign: TextAlign.center,
              style: TextStyle(color: grey, fontSize: 12),
            ),
            height20,
            SizedBox(
              height: 40,
              child: TextFormField(
                obscureText: false,
                controller: _emailController,
                autofocus: true,
                style: TextStyle(color: white, fontSize: 12),
                decoration: InputDecoration(
                  suffixIcon: _emailController.text.isEmpty
                      ? null
                      : IconButton(
                          onPressed: () {
                            _emailController.clear();
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
                  contentPadding: const EdgeInsets.only(left: 10),
                  hintText: 'Email',
                  hintStyle: TextStyle(color: grey, fontSize: 12),
                  filled: true,
                  fillColor: darkgrey,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: grey, width: 0.2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: grey, width: 0.2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            height10,
            SizedBox(
              height: 40,
              child: Form(
                key: _formkey,
                child: TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value!.length < 8) {
                      showError('Enter atleast 8 characters');
                      setState(() {
                        _haserror = true;
                      });
                      return '';
                    } else {
                      return null;
                    }
                  },
                  controller: _passwordController,
                  autofocus: true,
                  onChanged: (value) => setState(() {
                    _haserror = false;
                  }),
                  style: TextStyle(color: white, fontSize: 12),
                  decoration: InputDecoration(
                    suffixIcon: _passwordController.text.isEmpty
                        ? null
                        : IconButton(
                            onPressed: () {
                              _passwordController.clear();
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
                    contentPadding: const EdgeInsets.only(left: 10),
                    hintText: 'Password',
                    hintStyle: TextStyle(color: grey, fontSize: 12),
                    filled: true,
                    fillColor: darkgrey,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: grey, width: 0.2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: grey, width: 0.2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    errorStyle:
                        TextStyle(height: 0, color: _haserror ? red : blue),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: !_haserror ? grey : red,
                          width: !_haserror ? 0.2 : 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: !_haserror ? grey : red,
                          width: !_haserror ? 0.2 : 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Transform.scale(
                  scale: .8,
                  child: Checkbox(
                    visualDensity: const VisualDensity(horizontal: -4),
                    activeColor: blue,
                    side: BorderSide(
                      color: white,
                      width: 2,
                    ),
                    value: _checkbox,
                    onChanged: (value) {
                      setState(() {
                        _checkbox = value!;
                      });
                    },
                  ),
                ),
                Text(
                  'Save password',
                  style: TextStyle(color: grey, fontSize: 11),
                )
              ],
            ),
            height10,
            GestureDetector(
              onTap: () => !_button
                  ? null
                  : _formkey.currentState!.validate()
                      ? _nextButton(_emailController.text)
                      : null,
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

  Future<bool> isEmailRegistered(String email) async {
    try {
      List<String> signInMethods = await FirebaseAuth.instance
          .fetchSignInMethodsForEmail(_emailController.text);

      // If signInMethods is not empty, it means the email is already registered
      log(signInMethods.toString());
      if (signInMethods.isEmpty) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      // Handle error
      log("Error checking email registration: $e");
      return false;
    }
  }

  void _nextButton(String email) async {
    bool isRegistered = await isEmailRegistered(email);
    log(isRegistered.toString());
    if (isRegistered) {
      log("Email is already registered");
      showError('Email already in use');
    } else {
      log("Email is not registered");
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('password', _passwordController.text);
      prefs.setString('email', _emailController.text);
      Navigator.of(context).pushNamed('/details');
    }
  }

  void showError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        '   $error',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: red,
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      duration: const Duration(seconds: 3),
    ));
  }
}
