import 'package:flutter/material.dart';

class RecordMini extends StatefulWidget {
  @override
  _RecordMiniState createState() => _RecordMiniState();
}

class _RecordMiniState extends State<RecordMini> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xffDFF4F3), width: 1),
        borderRadius: BorderRadius.circular(10),
        shape: BoxShape.rectangle,
        // BoxShape.circle or BoxShape.retangle
      ),
    );
  }
}
