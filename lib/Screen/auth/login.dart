import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart%20';

import 'package:instagram_project/constant/colors.dart';
import 'package:instagram_project/constant/sizedbox.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  bool _button = false;
  bool _obscure = true;

  final _formkey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _emailController.addListener(_onTextChanged);
    _passwordController.addListener(_onTextChanged);
    super.initState();
  }

  void _onTextChanged() {
    setState(() {
      _button = _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }

  void login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
    } on FirebaseAuthException catch (_) {
      showError();
    }
  }

  void showError() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        '   Incorrect login details. Please try again.',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: red,
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      duration: const Duration(seconds: 3),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/kindpng_4545794.png',
                      height: 50,
                    ),
                    height20,
                    height10,
                    SizedBox(
                      height: 40,
                      child: TextFormField(
                        controller: _emailController,
                        style: TextStyle(color: white, fontSize: 12),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(left: 10),
                          hintText: 'Phone number, username or email address',
                          hintStyle: TextStyle(color: grey, fontSize: 12),
                          filled: true,
                          fillColor: darkgrey,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: grey, width: 0.1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: grey, width: 0.1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: red, width: 0.1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
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
                        controller: _passwordController,
                        obscureText: _obscure,
                        style: TextStyle(color: white, fontSize: 12),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(left: 10),
                          hintText: 'Password',
                          hintStyle: TextStyle(color: grey, fontSize: 12),
                          filled: true,
                          fillColor: darkgrey,
                          suffixIconConstraints: const BoxConstraints(
                            maxHeight: 50,
                            maxWidth: 50,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () => setState(() {
                              _obscure = !_obscure;
                            }),
                            icon: !_obscure
                                ? Image.asset(
                                    'assets/images/fluent--eye-16-filled.png',
                                    height: 50,
                                    width: 50,
                                  )
                                : Image.asset(
                                    'assets/images/fluent--eye-off-16-filled.png',
                                    height: 50,
                                    width: 50,
                                  ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: grey, width: 0.1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: grey, width: 0.1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: red, width: 0.1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: grey, width: 0.1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                    height10,
                    Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Forgotten Password?',
                          style: TextStyle(
                              color: blue,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        )),
                    height20,
                    GestureDetector(
                      onTap: () => _button ? login() : null,
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: _button ? blue : blue.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            'Log in',
                            style: TextStyle(
                                color: _button ? white : white.withOpacity(0.7),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    height20,
                    Row(
                      children: [
                        Expanded(
                            child: Divider(
                          color: grey,
                          thickness: 0.2,
                        )),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'OR',
                            style: TextStyle(
                                color: grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 10),
                          ),
                        ),
                        Expanded(
                            child: Divider(
                          color: grey,
                          thickness: 0.2,
                        ))
                      ],
                    ),
                    height20,
                    height10,
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/images/icons8-facebook-30.png'),
                        width5,
                        Text(
                          'Log in with Facebook',
                          style: TextStyle(
                            color: blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Column(
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       Divider(
            //         color: grey,
            //         thickness: 0.2,
            //       ),
            //       height20,
            //       Row(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           Text(
            //             "Don't have an account?",
            //             style: TextStyle(
            //               color: grey,
            //               fontSize: 10,
            //             ),
            //           ),
            //           width5,
            //           GestureDetector(
            //             onTap: () => Navigator.pushNamed(context, '/username'),
            //             child: Text(
            //               'Sign up',
            //               style: TextStyle(
            //                 fontWeight: FontWeight.bold,
            //                 color: blue,
            //                 fontSize: 10,
            //               ),
            //             ),
            //           )
            //         ],
            //       )
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            color: grey,
            thickness: 0.2,
          ),
          height20,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Don't have an account?",
                style: TextStyle(
                  color: grey,
                  fontSize: 10,
                ),
              ),
              width5,
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/signup'),
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: blue,
                    fontSize: 10,
                  ),
                ),
              )
            ],
          )
        ],
      ),
      // bottomSheet: BottomSheet(
      //   onClosing: () {},
      //   builder: (context) {
      //     return Column(
      //       mainAxisSize: MainAxisSize.min,
      //       children: [
      //         Divider(
      //           color: grey,
      //           thickness: 0.2,
      //         ),
      //         height20,
      //         Row(
      //           mainAxisSize: MainAxisSize.min,
      //           children: [
      //             Text(
      //               "Don't have an account?",
      //               style: TextStyle(
      //                 color: grey,
      //                 fontSize: 10,
      //               ),
      //             ),
      //             width5,
      //             GestureDetector(
      //               onTap: () => Navigator.pushNamed(context, '/username'),
      //               child: Text(
      //                 'Sign up',
      //                 style: TextStyle(
      //                   fontWeight: FontWeight.bold,
      //                   color: blue,
      //                   fontSize: 10,
      //                 ),
      //               ),
      //             )
      //           ],
      //         )
      //       ],
      //     );
      //   },
      // ),
    );
  }
}
