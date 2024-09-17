import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart%20';

import 'package:image_picker/image_picker.dart';
import 'package:instagram_project/Screen/Nav_bar/profile.dart';
import 'package:instagram_project/constant/colors.dart';
import 'package:instagram_project/constant/sizedbox.dart';

// ignore: must_be_immutable
class ScreenEditProfile extends StatefulWidget {
  final VoidCallback onEdit;
  ScreenEditProfile({
    super.key,
    required this.onEdit,
    required this.profile,
    required this.username,
    required this.bio,
  });
  String? profile;
  String username;
  String? bio;
  @override
  State<ScreenEditProfile> createState() => _ScreenEditProfileState();
}

class _ScreenEditProfileState extends State<ScreenEditProfile> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _bioController = TextEditingController();

  File? image;

  @override
  void initState() {
    _usernameController.text = widget.username;
    widget.bio!.isEmpty ? null : _bioController.text = widget.bio!;
    widget.profile!.isEmpty ? null : image = File(widget.profile!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(45),
        child: AppBar(
          backgroundColor: black,
          centerTitle: true,
          title: Text(
            'Edit Profile',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: white, fontSize: 15),
          ),
          leading: Icon(
            Icons.arrow_back_ios_new,
            color: white,
            size: 20,
          ),
          bottom: PreferredSize(
            preferredSize: Size.zero,
            child: Divider(
              height: 0,
              color: grey,
              thickness: 0.1,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          height20,
          CircleAvatar(
            radius: 35,
            backgroundImage: image != null
                ? FileImage(image!)
                : const AssetImage(
                        'assets/images/blank-profile-picture-973460_1280.png')
                    as ImageProvider,
          ),
          height10,
          GestureDetector(
            onTap: () => editPic(context),
            child: Text(
              'Edit picture',
              style: TextStyle(color: blue),
            ),
          ),
          Divider(
            color: grey,
            thickness: 0.1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Username',
                      style: TextStyle(
                        color: white,
                      ),
                    ),
                    SizedBox(
                      width: 235,
                      child: TextField(
                        style: TextStyle(color: white, fontSize: 12),
                        controller: _usernameController,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(bottom: 5),
                            hintText: 'Username',
                            hintStyle: TextStyle(color: grey, fontSize: 12),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none),
                      ),
                    )
                  ],
                ),
                Divider(
                  height: 0,
                  color: grey,
                  thickness: 0.1,
                  indent: 85,
                ),
                height10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Bio',
                      style: TextStyle(color: white),
                    ),
                    SizedBox(
                      width: 235,
                      child: TextField(
                        style: TextStyle(color: white, fontSize: 12),
                        controller: _bioController,
                        maxLines: null,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(bottom: 5),
                            hintText: 'Bio',
                            hintStyle: TextStyle(color: grey, fontSize: 12),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Divider(
            height: 10,
            color: grey,
            thickness: 0.1,
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              updateDB();
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: blue),
              child: Text(
                'Edit',
                style: TextStyle(color: white),
              ),
            ),
          )
        ],
      ),
    );
  }

  void editPic(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
              color: darkgrey,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5))),
          child: Column(
            children: [
              height10,
              Container(
                width: 35,
                height: 3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: grey),
              ),
              const Spacer(),
              ListTile(
                onTap: () => fromGallery(),
                visualDensity: const VisualDensity(vertical: -2),
                title: Text(
                  'Choose from library',
                  style: TextStyle(color: white),
                ),
                leading: Icon(
                  Icons.image_outlined,
                  color: white,
                ),
              ),
              ListTile(
                onTap: () => fromCamera(),
                visualDensity: const VisualDensity(vertical: -2),
                title: Text(
                  'Take photo',
                  style: TextStyle(color: white),
                ),
                leading: Icon(
                  Icons.photo_camera_outlined,
                  color: white,
                ),
              ),
              ListTile(
                onTap: () => removeimg(),
                visualDensity: const VisualDensity(vertical: -2),
                title: Text(
                  'Remove current picture',
                  style: TextStyle(color: red),
                ),
                leading: Icon(
                  Icons.delete,
                  color: red,
                ),
              ),
              height10,
            ],
          ),
        );
      },
    );
  }

  void removeimg() {
    image = null;
    Navigator.pop(context);
  }

  void fromCamera() async {
    Navigator.pop(context);
    final img = await ImagePicker().pickImage(source: ImageSource.camera);
    if (img != null) {
      setState(() {
        image = File(img.path);
      });
    }
  }

  void fromGallery() async {
    Navigator.pop(context);
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      setState(() {
        image = File(img.path);
      });
    }
  }

  void updateDB() async {
    setState(() {
      profileVariable.dataLoad = false;
    });
    final uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      await FirebaseFirestore.instance.collection('Users').doc(uid).update({
        'profile': image == null ? '' : image!.path,
        'bio': _bioController.text,
        'Username': _usernameController.text
      });
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("Post")
          .where('uid', isEqualTo: uid)
          .get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        DocumentReference docRef =
            FirebaseFirestore.instance.collection('Post').doc(doc.id);

        await docRef.update(
            {'profile': image!.path, 'username': _usernameController.text});
      }

      widget.onEdit();
    } catch (e) {
      log(e.toString());
    }
    Navigator.pop(context);
  }
}
