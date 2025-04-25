import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fire_base/auth/login.dart';
import 'package:fire_base/auth/update_password.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Get.offAll(Login());
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(
              child: Column(
                spacing: 15,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    snapshot.data!['name'],
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    snapshot.data!['email'],
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  ListTile(
                    title: Text("Update Password"),
                    trailing: Icon(Icons.arrow_right),
                    onTap: () {
                      Get.to(
                        UpdatePassword(),
                        transition: Transition.fadeIn,
                      );
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

// Leading - title - actions

// Page 3

// Firestore //

// read  50k
// write 20k

// StreamBuilder - FutureBuilder //

// "name" : "Mohamed" //
// name

// ['Mohamed','Eslam','Khadija']
// 1

// name of the map ["name"]
