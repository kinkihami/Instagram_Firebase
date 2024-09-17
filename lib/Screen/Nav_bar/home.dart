import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart%20';

import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:instagram_project/Screen/Nav_bar/profile.dart';
import 'package:instagram_project/constant/colors.dart';
import 'package:instagram_project/constant/sizedbox.dart';
import 'package:uuid/uuid.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  List like = [];
  List<String> postid = [];
  String profile = profileVariable.profile;
  String username = profileVariable.username;
  TextEditingController _commentController = TextEditingController();

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchPost() {
    return FirebaseFirestore.instance
        .collection('Post')
        .orderBy("datePublished", descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchComments(postid) {
    return FirebaseFirestore.instance
        .collection('Comments')
        .where('post_id', isEqualTo: postid)
        .snapshots();
  }

  void postComment(String uid, String postid) async {
    final cid = const Uuid().v4();
    await FirebaseFirestore.instance.collection('Comments').doc(cid).set({
      'uid': uid,
      'post_id': postid,
      'comment': _commentController.text,
      'username': username,
      'profile': profile,
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: black,
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: black,
                leadingWidth: 110,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Image.asset(
                    'assets/images/kindpng_4545794.png',
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      'assets/images/icons8-like-50.png',
                      height: 25,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      'assets/images/icons8-facebook-messenger-50 (1).png',
                      height: 25,
                    ),
                  ),
                ],

                floating: true,
                // forceElevated: innerBoxIsScrolled,
                expandedHeight: 50,
                snap: true,
              ),
            ];
          },
          body: ListView(
            children: [
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 32,
                                  backgroundColor: grey,
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
                          ),
                          height10,
                          Text(
                            'Your story',
                            style: TextStyle(color: grey, fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 7,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(right: 5, left: 5),
                                padding: const EdgeInsets.all(3),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: GradientBoxBorder(
                                    width: 2,
                                    gradient: LinearGradient(
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight,
                                        stops: [
                                          0.1,
                                          0.6,
                                          0.9,
                                        ],
                                        colors: [
                                          Color(0xfff9ce34),
                                          Color(0xffee2a7b),
                                          Color(0xff6228d7)
                                        ]),
                                  ),
                                ),
                                child: CircleAvatar(
                                  radius: 32,
                                  backgroundColor: blue,
                                ),
                              ),
                              height5,
                              Text(
                                'Your story',
                                style: TextStyle(color: grey, fontSize: 10),
                              ),
                            ],
                          );
                        }),
                  ],
                ),
              ),
              Divider(
                color: grey,
                thickness: 0.2,
              ),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: fetchPost(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      like.clear();
                      return ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: ((context, index) {
                            final data =
                                snapshot.data!.docs.elementAt(index).data();
                            postid.add(data['post_id']);
                            like.add(data['like']);
                            log(like.toString());
                            return Container(
                              padding: const EdgeInsets.only(bottom: 5),
                              margin: const EdgeInsets.only(bottom: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    dense: true,
                                    horizontalTitleGap: 8,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    leading: CircleAvatar(
                                      backgroundImage:
                                          FileImage(File(data['profile'])),
                                      radius: 15,
                                    ),
                                    title: Text(
                                      data['username'],
                                      style: TextStyle(
                                          color: white,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    trailing: Icon(
                                      Icons.more_horiz,
                                      color: white,
                                    ),
                                  ),
                                  GestureDetector(
                                    onDoubleTap: () =>
                                        likeButton(postid[index], like[index]),
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 400,
                                      child: Image.network(
                                        data['postUrl'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    dense: true,
                                    leading: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        GestureDetector(
                                          onTap: () => likeButton(
                                            postid[index],
                                            like[index],
                                          ),
                                          child: like[index].contains(uid)
                                              ? Image.asset(
                                                  'assets/images/icons8-heart-50.png',
                                                  height: 22,
                                                )
                                              : Image.asset(
                                                  'assets/images/icons8-like-50.png',
                                                  height: 22,
                                                ),
                                        ),
                                        width10,
                                        width5,
                                        GestureDetector(
                                          onTap: () => comments(
                                              postid[index], data['username']),
                                          child: Image.asset(
                                            'assets/images/icons8-comment-50 (1).png',
                                            height: 22,
                                          ),
                                        ),
                                        width10,
                                        width5,
                                        Image.asset(
                                          'assets/images/icons8-paper-plane-50 (3).png',
                                          height: 22,
                                        )
                                      ],
                                    ),
                                    trailing: Image.asset(
                                      'assets/images/icons8-bookmark-32.png',
                                      height: 22,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${like[index].length} likes',
                                          style: TextStyle(
                                              color: white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11),
                                        ),
                                        height5,
                                        Text.rich(TextSpan(
                                            text: '${data['username']} ',
                                            style: TextStyle(
                                                color: white,
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold),
                                            children: [
                                              TextSpan(
                                                text: data['description'],
                                                style: TextStyle(
                                                    color: white,
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ])),
                                        height5,
                                        Text(
                                          '2 hours ago',
                                          style: TextStyle(
                                              color: grey, fontSize: 11),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          }));
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  void comments(postid, name) {
    bool send = false;
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setModalState) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              width: double.infinity,
              height: 685,
              decoration: BoxDecoration(
                  color: darkgrey,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5), color: grey),
                    height: 4,
                    width: 35,
                  ),
                  Text(
                    'Comments',
                    style: TextStyle(
                      color: white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(
                    color: grey,
                    thickness: 0.2,
                  ),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: fetchComments(postid),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              physics: const ClampingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (ctx, index) {
                                final data =
                                    snapshot.data!.docs.elementAt(index).data();
                                return ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        FileImage(File(data['profile'])),
                                    backgroundColor: blue,
                                    radius: 15,
                                  ),
                                  title: Text(
                                    data['username'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: white,
                                      fontSize: 10,
                                    ),
                                  ),
                                  subtitle: Text(
                                    data['comment'],
                                    style:
                                        TextStyle(color: white, fontSize: 12),
                                  ),
                                );
                              },
                            );
                          } else {
                            return const Center(
                              child: Text('No Comments yet.'),
                            );
                          }
                        }),
                  ),
                  Divider(
                    height: 5,
                    color: grey,
                    thickness: 0.2,
                  ),
                  ListTile(
                    horizontalTitleGap: 10,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundImage: FileImage(File(profile)),
                    ),
                    title: SizedBox(
                      height: 40,
                      child: TextField(
                        controller: _commentController,
                        autofocus: true,
                        onChanged: (value) => setModalState(() {
                          value.isEmpty ? send = false : send = true;
                        }),
                        decoration: InputDecoration(
                          suffixIcon: !send
                              ? null
                              : GestureDetector(
                                  onTap: () {
                                    postComment(uid, postid);
                                    _commentController.clear();
                                  },
                                  child: Container(
                                    width: 40,
                                    margin: const EdgeInsets.only(
                                        top: 5, bottom: 5, right: 5),
                                    decoration: BoxDecoration(
                                        color: blue,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Icon(
                                      Icons.arrow_upward_rounded,
                                      color: white,
                                      size: 25,
                                    ),
                                  ),
                                ),
                          contentPadding:
                              const EdgeInsets.only(top: 0, left: 10),
                          hintText: 'Add a comment for $name',
                          hintStyle: TextStyle(color: grey, fontSize: 12),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: grey),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: grey),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        style: TextStyle(color: white, fontSize: 12),
                        cursorColor: blue,
                        keyboardType: TextInputType.text,
                        maxLines: null, // Allow multiple lines
                        minLines: 1, // At least one line
                        // onChanged: (value) {
                        //   // Handle value change
                        // },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  void likeButton(String postid, List like) async {
    if (like.contains(uid)) {
      List like1 = [];
      like1.addAll(like);
      like1.remove(uid);
      log(like1.toString());

      try {
        await FirebaseFirestore.instance
            .collection('Post')
            .doc(postid)
            .update({'like': like1});
        log('updated');
      } catch (e) {
        log(e.toString());
      }
    } else {
      List like1 = [];
      like1.addAll(like);
      like1.add(uid);
      log(like1.toString());

      try {
        await FirebaseFirestore.instance
            .collection('Post')
            .doc(postid)
            .update({'like': like1});
        log('updated');
      } catch (e) {
        log(e.toString());
      }
    }
  }
}
