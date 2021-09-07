import 'package:alo_doctor_doctor/ui/Screens/Prescription.dart';
import 'package:alo_doctor_doctor/ui/Screens/VideoCallingScreen.dart';
import 'package:flutter/material.dart';

import '../../utils/Colors.dart';

class AppointmentDetails extends StatelessWidget {
  final String Name;
  final String pId;
  final String time;
  final String date;
  final String email;
  final String number;

  AppointmentDetails(
      this.time, this.date, this.Name, this.number, this.email, this.pId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'My Appointments',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: accentBlueLight,
        leading: ElevatedButton(
          style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              backgroundColor: MaterialStateProperty.all(accentBlueLight)),
          child: Image(
            image: AssetImage('./assets/images/arrow.png'),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        iconTheme: Theme.of(context).iconTheme,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 40, 30, 15),
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(196, 196, 196, 0.1),
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage('assets/images/userdash.png'),
                      radius: 35,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Container(
                      width: 190,
                      child: Column(
                        children: [
                          Text(
                            Name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            ' ',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  child: Container(
                    height: 65,
                    width: 65,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.grey, style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(12)),
                    child: Image(
                      image: AssetImage('./assets/images/phone.png'),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VideoCallingScreen(pId)),
                    );
                  },
                  child: Container(
                    height: 65,
                    width: 65,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.grey, style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(12)),
                    child: Image(
                      image: AssetImage('./assets/images/video-camera.png'),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Prescription(pId)),
                    );
                  },
                  child: Container(
                    height: 65,
                    width: 65,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.grey, style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(12)),
                    child: Image(
                      image: AssetImage('./assets/images/upload.jpg'),
                    ),
                  ),
                ),
                InkWell(
                  child: Container(
                    height: 65,
                    width: 65,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.grey, style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(12)),
                    child: Image(
                      image: AssetImage('./assets/images/clock1.png'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Divider(
            thickness: 1,
            color: Color(0xff8C8FA5),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
            child: Text(
              'Upcoming',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 25,
                  width: 25,
                  child: Image(
                    image: AssetImage('./assets/images/clock.png'),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Video call',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      'Morning',
                      style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      date,
                      style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      time,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Divider(
            thickness: 1,
            color: Color(0xff8C8FA5),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
          //   child: Text(
          //     'History',
          //     style: TextStyle(
          //         color: Colors.black,
          //         fontSize: 15,
          //         fontWeight: FontWeight.w700),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Container(
          //         height: 25,
          //         width: 25,
          //         child: Image(
          //           image: AssetImage('./assets/images/clock.png'),
          //         ),
          //       ),
          //       SizedBox(
          //         width: 10,
          //       ),
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             'Video call',
          //             style: TextStyle(
          //                 color: Colors.black,
          //                 fontSize: 15,
          //                 fontWeight: FontWeight.w700),
          //           ),
          //           SizedBox(
          //             height: 3,
          //           ),
          //           Text(
          //             'Morning',
          //             style: TextStyle(
          //                 color: Colors.grey.shade600,
          //                 fontSize: 15,
          //                 fontWeight: FontWeight.w400),
          //           ),
          //           SizedBox(
          //             height: 2,
          //           ),
          //           Text(
          //             'Today-09 May, 2021',
          //             style: TextStyle(
          //                 color: Colors.grey.shade600,
          //                 fontSize: 15,
          //                 fontWeight: FontWeight.w400),
          //           ),
          //           SizedBox(
          //             height: 2,
          //           ),
          //           Text(
          //             '04:30pm to 5:30pm',
          //             style: TextStyle(
          //                 color: Colors.black,
          //                 fontSize: 15,
          //                 fontWeight: FontWeight.w700),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: Container(
          height: 56,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Color(0xffE6EAEA),
              border: Border.all(color: Color(0xffDFF4F3), width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffDFF4F3), width: 1),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      child: Center(
                        child: Text('Reschedule',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffDFF4F3), width: 1),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      child: Center(
                        child: Text('Cancel Appointment',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
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
