import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // const
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('events').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingAnimationWidget.discreteCircle(
                color: Colors.black, size: 40);
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  // Dismissible
                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) async {
                      await FirebaseFirestore.instance
                          .collection('events')
                          .doc(snapshot.data!.docs[index]['eventId'])
                          .delete();
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          spacing: 15,
                          children: [
                            Text(
                              snapshot.data!.docs[index]['name'],
                              style: const TextStyle(
                                  fontSize: 25, fontStyle: FontStyle.italic),
                            ),
                            CountdownTimer(
                              endWidget: const Text(
                                "Timeout\ntry again when available events are published",
                                textAlign: TextAlign.center,
                              ),
                              endTime: DateTime.now().millisecondsSinceEpoch +
                                  (snapshot.data!.docs[index]['start_date']
                                              as Timestamp)
                                          .toDate()
                                          .difference(DateTime.now())
                                          .inSeconds *
                                      1000,
                            ),
                            Text(snapshot.data!.docs[index]['location']),
                            ElevatedButton(
                              onPressed: () {
                                // Dialog
                                // CupertinoDialog
                                TextEditingController nameController =
                                    TextEditingController(
                                        text: snapshot.data!.docs[index]
                                            ['name']);
                                showCupertinoDialog(
                                  context: context,
                                  builder: (_) {
                                    return CupertinoAlertDialog(
                                      title: const Text("Edit Event"),
                                      content: Material(
                                        child: TextFormField(
                                          controller: nameController,
                                        ),
                                      ),
                                      actions: [
                                        CupertinoDialogAction(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Text("No"),
                                        ),
                                        CupertinoDialogAction(
                                          onPressed: () async {
                                            await FirebaseFirestore.instance
                                                .collection('events')
                                                .doc(snapshot.data!.docs[index]
                                                    ['eventId'])
                                                .update({
                                              'name': nameController.text,
                                            }).whenComplete(() {
                                              // setState(() {});
                                              Get.back();
                                            });
                                            // then - whenComplete - catchError
                                          },
                                          child: const Text("Yes"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: const Text("Edit"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}

// StreamBuilder - FutureBuilder //

// stream : source of data
// builder : design (ui)

// loop - SingleChildScrollview
// Listview.builder

// [1,10,8,3]
// length

// Datetime.now()

// eventStartDate

// Edit - Delete
// refactor auth
// const

// Sign up - Login - Forget Password - Update Password

// CRUD Operation - Create - Read - Update - Delete
