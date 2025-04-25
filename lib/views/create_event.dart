import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart' as date;

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  TextEditingController eventNamecontroller = TextEditingController();
  TextEditingController eventDescriptioncontroller = TextEditingController();
  TextEditingController eventLocationcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Event"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            TextFormField(
              controller: eventNamecontroller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Event Name'),
            ),
            TextFormField(
              controller: eventDescriptioncontroller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Description Name'),
            ),
            TextFormField(
              controller: eventLocationcontroller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Location Name'),
            ),
            Text(
              "Start Date",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 100,
              child: date.DatePicker(DateTime.now()),
            ),
            Text(
              "End Date",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 100,
              child: date.DatePicker(DateTime.now()),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                "Publish Event",
                style: TextStyle(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
