// ignore_for_file: prefer_interpolation_to_compose_strings


import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart%20';
import 'package:get/get.dart';
import 'package:instagram_project/Screen/profile/edit_profile.dart';
import 'package:instagram_project/Screen/profile/settings.dart';
import 'package:instagram_project/constant/colors.dart';
import 'package:instagram_project/constant/sizedbox.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class ScreenProfile extends StatefulWidget {
  const ScreenProfile({super.key});

  @override
  State<ScreenProfile> createState() => _ScreenProfileState();
}

class _ScreenProfileState extends State<ScreenProfile>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  String? description;

  @override
  void initState() {
    postVariable.load ? null : fetchPost();
    // postUrl.clear();
    tabController = TabController(length: 2, vsync: this);
    !profileVariable.dataLoad ? fetchData() : null;
    super.initState();
  }

  void onDataEdited() {
    setState(() {
      profileVariable.dataLoad = false;
    });
    fetchData();
  }

  void fetchPost() async {
    postVariable.post.clear();
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final QuerySnapshot postSnapshot = await FirebaseFirestore.instance
        .collection('Post')
        .orderBy("datePublished", descending: true)
        .where('uid',
            isEqualTo:
                uid) // Filter documents where 'uid' field matches current user's UID
        .get();

    setState(() {
      // Iterate through each document snapshot and retrieve data
      postSnapshot.docs.forEach((doc) {
        // Access data using doc.data() and update your local variables
        postVariable.post.add(doc['postUrl']);
        // description = doc['description'];

        // Add more fields as needed
      });
    });
    setState(() {
      postVariable.load = true;
    });
  }

  void fetchData() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('Users').doc(uid).get();

    setState(() {
      profileVariable.profile = userDoc.get('profile');
      profileVariable.followers = userDoc.get('Followers');
      profileVariable.followers = userDoc.get('Following');
      profileVariable.bio = userDoc.get('bio');
      profileVariable.username = userDoc.get('Username');
      profileVariable.dataLoad = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: !profileVariable.dataLoad
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              backgroundColor: black,
              appBar: AppBar(
                backgroundColor: black,
                leading: Padding(
                  padding: const EdgeInsets.only(top: 15, left: 10),
                  child: Text(
                    profileVariable.username,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 22,
                      color: white,
                    ),
                  ),
                ),
                leadingWidth: 200,
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      'assets/images/basil--add-outline.png',
                      height: 28,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.to(
                        () => const ScreenSettings(),
                        transition: Transition.rightToLeft,
                        duration: const Duration(milliseconds: 250),
                      );
                    },
                    icon: Icon(
                      Icons.menu_rounded,
                      color: white,
                    ),
                  ),
                ],
              ),
              body: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 35,
                                  backgroundImage: FileImage(
                                      File(profileVariable.profile.toString())),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border:
                                            Border.all(color: black, width: 2),
                                        color: blue),
                                    child: Icon(
                                      Icons.add,
                                      color: white,
                                      size: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '${postVariable.post.length}\n',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: white,
                                          fontSize: 15,
                                        ),
                                      ),
                                      TextSpan(
                                          text: 'posts',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 12,
                                              color: white))
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                width20,
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: profileVariable.followers.length
                                                .toString() +
                                            '\n',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: white,
                                          fontSize: 15,
                                        ),
                                      ),
                                      TextSpan(
                                          text: 'followers',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 12,
                                              color: white))
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                width20,
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: profileVariable.following.length
                                                .toString() +
                                            '\n',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: white,
                                          fontSize: 15,
                                        ),
                                      ),
                                      TextSpan(
                                          text: 'following',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 12,
                                              color: white))
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                width20
                              ],
                            ),
                          ],
                        ),
                        height10,
                        Text(
                          'Personal blog',
                          style: TextStyle(
                            color: lightblue,
                            fontSize: 12,
                          ),
                        ),
                        profileVariable.bio.isNotEmpty
                            ? Text(
                                profileVariable.bio.toString(),
                                style: TextStyle(
                                  color: white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              )
                            : const SizedBox(),
                        height10,
                        Row(
                          children: [
                            Expanded(
                                child: GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => ScreenEditProfile(
                                          onEdit: onDataEdited,
                                          profile: profileVariable.profile,
                                          username: profileVariable.username,
                                          bio: profileVariable.bio))),
                              child: Container(
                                height: 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: darkgrey),
                                child: Center(
                                  child: Text(
                                    'Edit profile',
                                    style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            )),
                            width5,
                            Expanded(
                                child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: darkgrey),
                              child: Center(
                                child: Text(
                                  'Share profile',
                                  style: TextStyle(
                                    color: white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ))
                          ],
                        ),
                      ],
                    ),
                  ),
                  TabBar(
                    indicatorColor: white,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorWeight: 1.5,
                    labelColor: white,
                    unselectedLabelColor: grey,
                    dividerColor: black,
                    controller: tabController,
                    tabs: const [
                      Tab(
                        icon: Icon(Icons.grid_on),
                      ),
                      Tab(
                        icon: Icon(Icons.person_pin_outlined),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        !postVariable.load
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : postVariable.post.isEmpty
                                ? Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          height: 80,
                                          width: 80,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: white, width: 3),
                                              shape: BoxShape.circle),
                                          child: Icon(
                                            Icons.photo_camera_outlined,
                                            color: white,
                                            size: 50,
                                          ),
                                        ),
                                        height10,
                                        Text(
                                          'No Posts Yet',
                                          style: TextStyle(
                                              color: white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22),
                                        ),
                                      ],
                                    ),
                                  )
                                : const Post(),
                        const Tagged(),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

class Post extends StatelessWidget {
  const Post({super.key});

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.count(
      crossAxisSpacing: 1.5,
      mainAxisSpacing: 1.5,
      crossAxisCount: 3,
      staggeredTiles: List.generate(
          postVariable.post.length, (index) => const StaggeredTile.fit(1)),
      children: List.generate(
        postVariable.post.length,
        (index) {
          return Image.network(
            postVariable.post[index],
            height: 120,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}

class Tagged extends StatelessWidget {
  const Tagged({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                border: Border.all(color: white, width: 3),
                shape: BoxShape.circle),
            child: Icon(
              Icons.photo_camera_outlined,
              color: white,
              size: 50,
            ),
          ),
          height10,
          Text(
            'No Posts Yet',
            style: TextStyle(
                color: white, fontWeight: FontWeight.bold, fontSize: 22),
          ),
        ],
      ),
    );
  }
}

ProfileVariable profileVariable = ProfileVariable();

class ProfileVariable {
  String username = '';
  List followers = [];
  List following = [];
  String bio = '';
  String profile = '';
  bool dataLoad = false;
}

PostVariable postVariable = PostVariable();

class PostVariable {
  bool load = false;
  List<String> post = [];
}
