// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart%20';
// import 'package:flutter/widgets.dart';
// import 'package:instagram_project/constant/colors.dart';
// import 'package:instagram_project/constant/sizedbox.dart';

// class ScreenPhoneEmail extends StatefulWidget {
//   const ScreenPhoneEmail({super.key});

//   @override
//   State<ScreenPhoneEmail> createState() => _ScreenPhoneEmailState();
// }

// class _ScreenPhoneEmailState extends State<ScreenPhoneEmail>
//     with TickerProviderStateMixin {
//   late TabController tabController;

//   @override
//   void initState() {
//     super.initState();
//     tabController = TabController(length: 2, vsync: this);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: black,
//       appBar: AppBar(
//         toolbarHeight: 30,
//         backgroundColor: black,
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: Icon(
//               Icons.arrow_back_ios_new,
//               color: white,
//             )),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           children: [
//             Text(
//               'Add phone number or\nemail address',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                   fontSize: 22, fontWeight: FontWeight.bold, color: white),
//             ),
//             height20,
//             TabBar(
//               indicatorColor: white,
//               indicatorSize: TabBarIndicatorSize.tab,
//               indicatorWeight: 1.5,
//               unselectedLabelColor: grey,
//               dividerColor: grey,
//               controller: tabController,
//               tabs: const [
//                 Tab(
//                   text: 'Phone',
//                 ),
//                 Tab(
//                   text: 'Email',
//                 ),
//               ],
//               labelStyle: TextStyle(
//                   color: white, fontSize: 17, fontWeight: FontWeight.bold),
//             ),
//             Expanded(
//                 child: TabBarView(
//                     controller: tabController,
//                     children: const [PhoneScreen(), EmailScreen()])),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class PhoneScreen extends StatefulWidget {
//   const PhoneScreen({super.key});

//   @override
//   State<PhoneScreen> createState() => _PhoneScreenState();
// }

// class _PhoneScreenState extends State<PhoneScreen> {
//   bool _button = false;

//   final TextEditingController _usernameController = TextEditingController();

//   @override
//   void initState() {
//     _usernameController.addListener(_onTextChanged);
//     super.initState();
//   }

//   void _onTextChanged() {
//     setState(() {
//       _button = _usernameController.text.isNotEmpty;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           margin: const EdgeInsets.only(top: 15),
//           height: 40,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(5),
//               border: Border.all(color: grey, width: 0.2)),
//           child: IntrinsicHeight(
//             child: Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   child: Text(
//                     'lN +91',
//                     style: TextStyle(color: blue, fontSize: 12),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 8),
//                   child: VerticalDivider(
//                     width: 0,
//                     color: grey,
//                     thickness: 0.2,
//                   ),
//                 ),
//                 Expanded(
//                   child: TextFormField(
//                     cursorHeight: 16,
//                     style: TextStyle(color: white, fontSize: 12, height: 1.3),
//                     decoration: InputDecoration(
//                       hintText: 'Phone number',
//                       hintStyle: TextStyle(color: grey),
//                       isDense: true,
//                       border: InputBorder.none,
//                       contentPadding:
//                           const EdgeInsets.symmetric(horizontal: 10),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         height20,
//         GestureDetector(
//           onTap: () {
//             // Navigator.pushReplacementNamed(context, '/nav_bar');
//             // FirebaseAuth.instance.createUserWithEmailAndPassword(
//             //     email: 'hami', password: '0000');
//           },
//           child: Container(
//             height: 40,
//             width: double.infinity,
//             decoration: BoxDecoration(
//                 color: _button ? blue : blue.withOpacity(0.3),
//                 borderRadius: BorderRadius.circular(10)),
//             child: Center(
//               child: Text(
//                 'Next',
//                 style: TextStyle(
//                     color: _button ? white : white.withOpacity(0.7),
//                     fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//         ),
//         height10,
//         Text(
//           'You may recieve SMS notification from us for security\nand login purposes.',
//           textAlign: TextAlign.center,
//           style: TextStyle(color: grey, fontSize: 11),
//         )
//       ],
//     );
//   }
// }

// class EmailScreen extends StatefulWidget {
//   const EmailScreen({super.key});

//   @override
//   State<EmailScreen> createState() => _EmailScreenState();
// }

// class _EmailScreenState extends State<EmailScreen> {
//   bool _button = false;

//   final TextEditingController _emailController = TextEditingController();

//   @override
//   void initState() {
//     _emailController.addListener(_onTextChanged);
//     super.initState();
//   }

//   void _onTextChanged() {
//     setState(() {
//       _button = _emailController.text.isNotEmpty;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           margin: const EdgeInsets.only(top: 15),
//           height: 40,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(5),
//               border: Border.all(color: grey, width: 0.2)),
//           child: TextFormField(
//             cursorHeight: 16,
//             style: TextStyle(color: white, fontSize: 12, height: 1.3),
//             decoration: InputDecoration(
//               hintText: 'Email address',
//               hintStyle: TextStyle(color: grey),
//               isDense: true,
//               border: InputBorder.none,
//               contentPadding:
//                   const EdgeInsets.symmetric(horizontal: 10, vertical: 11),
//             ),
//           ),
//         ),
//         height20,
//         GestureDetector(
//           onTap: () => Navigator.pushReplacementNamed(context, '/nav_bar'),
//           child: Container(
//             height: 40,
//             width: double.infinity,
//             decoration: BoxDecoration(
//                 color: _button ? blue : blue.withOpacity(0.3),
//                 borderRadius: BorderRadius.circular(10)),
//             child: Center(
//               child: Text(
//                 'Next',
//                 style: TextStyle(
//                     color: _button ? white : white.withOpacity(0.7),
//                     fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
