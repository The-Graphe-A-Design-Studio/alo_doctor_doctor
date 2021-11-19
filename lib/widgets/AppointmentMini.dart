import 'package:alo_doctor_doctor/utils/styles.dart';
import 'package:flutter/material.dart';

import '../utils/DateFormatter.dart';

class AppointmentMini extends StatefulWidget {
  String Name;
  String time;
  String date;
  String path;
  Function onTap;
  bool isSelected;

  AppointmentMini({
    this.Name,
    this.time,
    this.date,
    this.onTap,
    this.path,
    this.isSelected,
    Key key,
  }) : super(key: key);

  @override
  _AppointmentMiniState createState() => _AppointmentMiniState();
}

class _AppointmentMiniState extends State<AppointmentMini> {
  @override
  Widget build(BuildContext context) {
    // print(DateFormatter().getVerboseDateTimeRepresentation(
    //         DateTime.parse(widget.date + " " + widget.time.split(' ')[0])
    //             .subtract(Duration(days: 5))) +
    //     widget.time.split(' ')[1]);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          height: 66,
          decoration: BoxDecoration(
              color: widget.isSelected ? Color(0xffE9F98F) : Colors.transparent,
              border: Border.all(color: Color(0xffDFF4F3), width: 1),
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image(
                    image: widget.path == null
                        ? NetworkImage(
                            "https://tse2.mm.bing.net/th?id=OIP.e8X4CTvV9XF1DJHi47CCBgHaHa&pid=Api&P=0&w=300&h=300")
                        : NetworkImage(
                            'https://developers.thegraphe.com/alodoctor/public${widget.path}'),
                    height: 40,
                    width: 40,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.Name.split(" ").length > 1
                          ? widget.Name.split(" ")[0] +
                              " " +
                              widget.Name.split(" ")[1]
                          : widget.Name,
                      style: Styles.buttonTextBlackBold,
                    ),
                    Row(
                      children: [
                        Text(
                          DateFormatter().getVerboseDateTimeRepresentation(
                                  DateTime.parse(widget.date +
                                      " " +
                                      widget.time.split(' ')[0])) +
                              " " +
                              widget.time.split(' ')[1],
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                        // Text(
                        //   widget.time == null ? '' : widget.time,
                        //   style: TextStyle(
                        //       fontSize: 12,
                        //       fontWeight: FontWeight.w400,
                        //       color: Colors.black),
                        // ),
                      ],
                    )
                  ],
                ),
                Expanded(child: Container()),
                // Image(
                //   image: AssetImage('assets/images/babydash.png'),
                //   height: 33,
                //   width: 22,
                //   fit: BoxFit.fill,
                // ),
                SizedBox(
                  width: 32,
                ),
                RotatedBox(
                  quarterTurns: 2,
                  child: Image(
                    image: AssetImage(
                      'assets/images/planeArrow.png',
                    ),
                    height: 15.0,
                    width: 15.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
