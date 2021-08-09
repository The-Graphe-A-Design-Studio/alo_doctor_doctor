import 'package:flutter/material.dart';

class ReminderList extends StatelessWidget {
  final String label;
  final String date;
  final String time;
  final String num;
  const ReminderList({
    this.time,
    this.label,
    this.date,
    this.num,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xffDFF4F3), width: 1),
          borderRadius: BorderRadius.circular(10),
          shape: BoxShape.rectangle,
          // BoxShape.circle or BoxShape.retangle
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      label,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      Text(
                        date,
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        time,
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        num,
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                    ],
                  )
                ],
              ),
              Expanded(child: Container()),
              Image(
                image: AssetImage(
                  'assets/images/trash.png',
                ),
                height: 20,
                width: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
