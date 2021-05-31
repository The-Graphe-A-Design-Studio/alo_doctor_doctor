import 'package:flutter/material.dart';

class CalendarReminder extends StatelessWidget {
  final String time;
  final String labelM;
  final String labelS;
  const CalendarReminder({
    this.time,
    this.labelM,
    this.labelS,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xffDFF4F3),
                width: 2,
              ),
              shape: BoxShape.circle,
            ),
            height: 72,
            width: 72,
            child: Center(
                child: Text(
              time,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  fontWeight: FontWeight.w400),
            )),
          ),
          SizedBox(
            width: 30,
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    labelM,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  labelS,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
