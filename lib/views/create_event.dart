import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart' as date;
import 'package:fire_base/common_functions/show_flushbar.dart';
import 'package:uuid/uuid.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  TextEditingController eventNameController = TextEditingController();
  TextEditingController eventDescriptionController = TextEditingController();
  TextEditingController eventLocationController = TextEditingController();

  DateTime eventStartDate = DateTime.now();
  DateTime eventEndDate = DateTime.now();

  bool loading = false;

  publishEvent() async {
    setState(() {
      loading = true;
    });

    try {
      String eventId = const Uuid().v4();
      await FirebaseFirestore.instance.collection('events').doc(eventId).set({
        'name': eventNameController.text,
        'description': eventDescriptionController.text,
        'location': eventLocationController.text,
        'start_date': eventStartDate,
        'end_date': eventEndDate,
        'eventId': eventId,
        'uid': FirebaseAuth.instance.currentUser!.uid,
      });
      setState(() {
        loading = false;
      });
      showSuccess("Successfully published", context);
    } catch (e) {
      setState(() {
        loading = false;
      });
      showError(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Event"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            TextFormField(
              controller: eventNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Event Name',
              ),
            ),
            TextFormField(
              maxLines: 4,
              controller: eventDescriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Event Description',
              ),
            ),
            TextFormField(
              controller: eventLocationController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Event Location Name',
              ),
            ),
            const Text(
              "Start Date",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 100,
              child: date.DatePicker(
                DateTime.now(),
                selectionColor: Colors.black,
                onDateChange: (date) {
                  setState(() {
                    eventStartDate = date;
                  });
                },
              ),
            ),
            const Text(
              "End Date",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 100,
              child: date.DatePicker(
                DateTime.now(),
                selectionColor: Colors.black,
                onDateChange: (date) {
                  setState(() {
                    eventEndDate = date;
                  });
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                publishEvent();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: loading == true
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Publish Event"),
            ),
          ],
        ),
      ),
    );
  }
}

// connect with firebase
