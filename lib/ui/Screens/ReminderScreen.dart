import 'package:alo_doctor_doctor/utils/Colors.dart';
import 'package:alo_doctor_doctor/widgets/ReminderList.dart';
import 'package:flutter/material.dart';

class ReminderScreen extends StatefulWidget {
  @override
  _ReminderScreenState createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Image(
              image: AssetImage(
                'assets/images/arrow.png',
              ),
              height: 18.0,
              width: 30.0,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
          ),
        ],
        title: Column(
          children: [
            Text(
              'Reminders',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
        centerTitle: true,
        backgroundColor: accentBlueLight,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, bottom: 40.0, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReminderList(
                  label: 'Acceptance form  MR Rai ',
                  date: '12:05:2021',
                  time: '10:00AM',
                  num: 'OneTime'),
              ReminderList(
                  label: 'Look in the Matter',
                  date: '12:05:2021',
                  time: '11:00AM',
                  num: 'OneTime'),
              ReminderList(
                  label: 'Summer Health',
                  date: '12:05:2021',
                  time: '11:00AM',
                  num: 'OneTime'),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        elevation: 1.0,
        child: new Icon(
          Icons.add,
          color: Colors.black,
        ),
        backgroundColor: new Color(0xFFDFF4F3),
      ),
    );
  }
}
