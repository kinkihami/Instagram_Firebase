import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ScreenReels extends StatefulWidget {
  const ScreenReels({super.key});

  @override
  State<ScreenReels> createState() => _ScreenReelsState();
}

class _ScreenReelsState extends State<ScreenReels> {
  bool data = true;
  Future<void> _asyncOperation() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('Users').doc(uid).get();

    String profile = userDoc.get('profile');
    String username = userDoc.get('Username');
    log(profile);
    log(username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Linear Progress Indicator with Async Completion'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  data = false;
                });
              },
              child: Text('Start Async Operation'),
            ),
            SizedBox(height: 20),
            data
                ? Container()
                : _buildProgressIndicator(), // Linear progress indicator
          ],
        ),
      ),
    );
  }

  // Function to start the async operation and update the progress
  Widget _buildProgressIndicator() {
    return FutureBuilder(
      future: _asyncOperation(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // If the async operation is in progress, display the linear progress indicator
          return LinearProgressIndicator();
        } else {
          // If the async operation is completed, display a completed message or other UI
          return Text('Async Operation Completed');
        }
      },
    );
  }
}
