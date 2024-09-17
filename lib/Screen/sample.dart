// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart%20';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:instagram_project/constant/colors.dart';
// import 'package:staggered_grid_view_flutter/widgets/sliver.dart';
// import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

// class SamplePage extends StatelessWidget {
//   const SamplePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: black,
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             backgroundColor: Colors.black,
//             leading: Padding(
//               padding: const EdgeInsets.only(top: 15, left: 10),
//               child: Text(
//                 '_hami_ham_',
//                 style: TextStyle(
//                   fontWeight: FontWeight.w900,
//                   fontSize: 22,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             actions: [
//               IconButton(
//                 onPressed: () {
//                   Navigator.of(context)
//                       .push(MaterialPageRoute(builder: (ctx) => SamplePage()));
//                 },
//                 icon: Image.asset(
//                   'assets/images/basil--add-outline.png',
//                   height: 28,
//                 ),
//               ),
//               IconButton(
//                 onPressed: () {},
//                 icon: Icon(
//                   Icons.menu_rounded,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.all(15),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Stack(
//                         children: [
//                           CircleAvatar(
//                             radius: 35,
//                             backgroundColor: Colors.grey,
//                           ),
//                           Positioned(
//                             bottom: 0,
//                             right: 0,
//                             child: Container(
//                               padding: const EdgeInsets.all(3),
//                               decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   border:
//                                       Border.all(color: Colors.black, width: 2),
//                                   color: Colors.blue),
//                               child: Icon(
//                                 Icons.add,
//                                 color: Colors.white,
//                                 size: 13,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Text.rich(
//                             TextSpan(
//                               children: [
//                                 TextSpan(
//                                   text: '16\n',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white,
//                                     fontSize: 15,
//                                   ),
//                                 ),
//                                 TextSpan(
//                                     text: 'posts',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.normal,
//                                         fontSize: 12,
//                                         color: Colors.white))
//                               ],
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                           SizedBox(width: 20),
//                           Text.rich(
//                             TextSpan(
//                               children: [
//                                 TextSpan(
//                                   text: '1,214\n',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white,
//                                     fontSize: 15,
//                                   ),
//                                 ),
//                                 TextSpan(
//                                     text: 'followers',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.normal,
//                                         fontSize: 12,
//                                         color: Colors.white))
//                               ],
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                           SizedBox(width: 20),
//                           Text.rich(
//                             TextSpan(
//                               children: [
//                                 TextSpan(
//                                   text: '701\n',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white,
//                                     fontSize: 15,
//                                   ),
//                                 ),
//                                 TextSpan(
//                                     text: 'following',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.normal,
//                                         fontSize: 12,
//                                         color: Colors.white))
//                               ],
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                           SizedBox(width: 20)
//                         ],
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Personal blog',
//                     style: TextStyle(
//                       color: Colors.lightBlue,
//                       fontSize: 12,
//                     ),
//                   ),
//                   Text(
//                     'bio',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 12,
//                     ),
//                   ),
//                   Text(
//                     'bio',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 12,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Container(
//                           height: 30,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(7),
//                               color: Colors.grey),
//                           child: Center(
//                             child: Text(
//                               'Edit profile',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 5),
//                       Expanded(
//                         child: Container(
//                           height: 30,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(7),
//                               color: Colors.grey),
//                           child: Center(
//                             child: Text(
//                               'Share profile',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           TabBar(
//                       indicatorColor: white,
//                       indicatorSize: TabBarIndicatorSize.tab,
//                       indicatorWeight: 1.5,
//                       labelColor: white,
//                       unselectedLabelColor: grey,
//                       dividerColor: black,
//                       controller: tabController,
//                       tabs: const [
//                         Tab(
//                           icon: Icon(Icons.grid_on),
//                         ),
//                         Tab(
//                           icon: Icon(Icons.person_pin_outlined),
//                         ),
//                       ],
//                     ),
//                     Expanded(
//                       child: TabBarView(
//                         controller: tabController,
//                         children: const [
//                           Post(),
//                           Tagged(),
//                         ],
//                       ),
//                     )
//         ],
//       ),
//     );
//   }
// }


// showModalBottomSheet(
//                                     backgroundColor: Colors.transparent,
//                                     context: context,
//                                     builder: (context) => DraggableScrollableSheet(
//       minChildSize: 0.5,
//       maxChildSize: 0.9,
//       initialChildSize: 0.9,
//       builder: (_, controller) {
//         return Padding(
//           padding:
//               EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//           child: Container(
//             padding: EdgeInsets.only(
//                 bottom: MediaQuery.of(context).viewInsets.bottom),
//             width: double.infinity,
//             height: 670,
//             decoration: BoxDecoration(
//                 color: darkgrey,
//                 borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(10),
//                     topRight: Radius.circular(10))),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   margin: const EdgeInsets.only(top: 10, bottom: 20),
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5), color: grey),
//                   height: 4,
//                   width: 35,
//                 ),
//                 Text(
//                   'Comments',
//                   style: TextStyle(
//                     color: white,
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Divider(
//                   color: grey,
//                   thickness: 0.2,
//                 ),
//                 Expanded(
//                   child: ListView.builder(
//                     physics: const ClampingScrollPhysics(),
//                     scrollDirection: Axis.vertical,
//                     shrinkWrap: true,
//                     itemCount: 15,
//                     itemBuilder: (ctx, index) {
//                       return ListTile(
//                         contentPadding:
//                             const EdgeInsets.symmetric(horizontal: 10),
//                         leading: CircleAvatar(
//                           backgroundColor: blue,
//                           radius: 15,
//                         ),
//                         title: Text(
//                           'jamsheer._',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: white,
//                             fontSize: 10,
//                           ),
//                         ),
//                         subtitle: Text(
//                           'Thijjj',
//                           style: TextStyle(color: white, fontSize: 12),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 Divider(
//                   height: 5,
//                   color: grey,
//                   thickness: 0.2,
//                 ),
//                 ListTile(
//                   horizontalTitleGap: 10,
//                   contentPadding: const EdgeInsets.symmetric(horizontal: 12),
//                   leading: CircleAvatar(
//                     radius: 20,
//                     backgroundColor: blue,
//                   ),
//                   title: SizedBox(
//                     height: 40,
//                     child: TextField(
//                       autofocus: true,
//                       decoration: InputDecoration(
//                         contentPadding: const EdgeInsets.only(top: 0, left: 10),
//                         hintText: 'Add a comment for shih4b_',
//                         hintStyle: TextStyle(color: grey, fontSize: 12),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: grey),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: grey),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                       style: TextStyle(color: grey, fontSize: 12),
//                       cursorColor: grey,
//                       keyboardType: TextInputType.text,
//                       maxLines: null, // Allow multiple lines
//                       minLines: 1, // At least one line
//                       // onChanged: (value) {
//                       //   // Handle value change
//                       // },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     ),
//                                     isScrollControlled: true,
//                                   ),

