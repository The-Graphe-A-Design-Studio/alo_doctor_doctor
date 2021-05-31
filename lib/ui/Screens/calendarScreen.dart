import 'package:alo_doctor_doctor/utils/Colors.dart';
import 'package:alo_doctor_doctor/widgets/calendarReminder.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
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
              Icons.notifications_none,
              color: Colors.black,
            ),
          ),
        ],
        title: Column(
          children: [
            Text(
              'Calendar',
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
          padding: const EdgeInsets.only(bottom: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: DateTime.now(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Morning',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff8C8FA5)),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CalendarReminder(
                        time: '9-10',
                        labelM: 'Visit Lelavati hospital, Mumbai',
                        labelS: 'Bandra east, khau galli, east west 422010')
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Evening',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff8C8FA5)),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CalendarReminder(
                        time: '9-10',
                        labelM: 'Visit Lelavati hospital, Mumbai',
                        labelS: 'Bandra east, khau galli, east west 422010')
                  ],
                ),
              ),
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
