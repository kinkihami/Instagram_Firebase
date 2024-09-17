import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart%20';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_project/Screen/Nav_bar/profile.dart';
import 'package:instagram_project/constant/colors.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:uuid/uuid.dart';

// File? image;
// String imageUrl = '';
bool upload = false;
double perc = 0;

class ScreenAdd extends StatefulWidget {
  const ScreenAdd({super.key});

  @override
  State<ScreenAdd> createState() => _ScreenAddState();
}

class _ScreenAddState extends State<ScreenAdd> {
  TextEditingController _descriptionController = TextEditingController();

  File? image;
  String imageUrl = '';
  String? profile;
  String? username;
  String? userid;
  bool added = false;
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('Users').doc(uid).get();

    setState(() {
      profile = userDoc.get('profile');
      username = userDoc.get('Username');
      userid = uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: black,
          centerTitle: true,
          title: Text(
            'New post',
            style: TextStyle(
              color: white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        backgroundColor: black,
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    border: Border.all(color: darkgrey),
                    image: image == null
                        ? null
                        : DecorationImage(
                            image: FileImage(
                              image!,
                            ),
                            fit: BoxFit.cover,
                          ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 250,
                  width: 200,
                  child: image != null
                      ? null
                      : FittedBox(
                          fit: BoxFit.none,
                          child: GestureDetector(
                            onTap: () => fromGallery(),
                            child: Container(
                              width: 90,
                              height: 35,
                              decoration: BoxDecoration(
                                  color: darkgrey,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  'Add post',
                                  style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
                TextField(
                  controller: _descriptionController,
                  style: TextStyle(color: white, fontSize: 12),
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'Write a caption',
                    hintStyle: TextStyle(color: grey, fontSize: 12),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () => sharePost(),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
                color: !added ? blue.withOpacity(0.3) : blue,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: !upload
                    ? Text(
                        'Share',
                        style: TextStyle(
                            color: !added ? white.withOpacity(0.7) : white,
                            fontWeight: FontWeight.bold),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: LinearPercentIndicator(
                          percent: perc,
                          progressColor: white,
                          backgroundColor: grey,
                          barRadius: const Radius.circular(20),
                        ),
                      )),
          ),
        ),
      ),
    );
  }

  Future<void> fromGallery() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      setState(() {
        image = File(img.path);
        added = true;
      });
    }
  }

  Future<void> sharePost() async {
    if (image != null) {
      setState(() {
        upload = true;
      });
      String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();

      Reference referenceroot = FirebaseStorage.instance.ref();
      Reference referenceimg = referenceroot.child('images_post');
      Reference referenceimgtoupload = referenceimg.child(uniqueFileName);

      final uploadTask = referenceimgtoupload.putFile(File(image!.path));
      uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
        switch (taskSnapshot.state) {
          case TaskState.running:
            final progress =
                100 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);

            setState(() {
              log(perc.toString());
              perc = (progress / 100).toDouble();
            });
            log('upload is ${progress.toStringAsFixed(1)} completed');
            break;

          case TaskState.paused:
            log('upload has been paused');
            break;

          case TaskState.canceled:
            log('Upload was canceled');
            break;

          case TaskState.error:
            log('Error while uploading');
            break;

          case TaskState.success:
            log('Successfully uploaded');
            setState(() {
              upload = false;

              added = false;

              perc = 0;
              postVariable.load = false;
            });
            imageUrl = await referenceimgtoupload.getDownloadURL();
            log(imageUrl);
            try {
              final postid = const Uuid().v1();
              final date = DateTime.now();
              FirebaseFirestore.instance.collection('Post').doc(postid).set({
                'datePublished': date,
                'postUrl': imageUrl,
                'description': _descriptionController.text,
                'post_id': postid,
                'like': [],
                'username': username,
                'uid': userid,
                'profile': profile
              });

              setState(() {
                _descriptionController.clear();
                image = null;
              });
            } catch (e) {
              log(e.toString());
            }

            break;
        }
      });
    }
  }
}
