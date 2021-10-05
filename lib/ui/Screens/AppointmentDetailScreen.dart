import 'package:alo_doctor_doctor/ui/Screens/ConsultationSchedule.dart';
import 'package:alo_doctor_doctor/ui/Screens/RescheduleBooking.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../utils/Colors.dart';
import 'package:alo_doctor_doctor/ui/Screens/Prescription.dart';
import 'package:alo_doctor_doctor/ui/Screens/VideoCallingScreen.dart';
// import 'package:alo_doctor_doctor/ui/Screens/ViewPrescriptionScreen.dart';
import 'package:alo_doctor_doctor/ui/Screens/ViewReport.dart';
import 'package:alo_doctor_doctor/utils/MyConstants.dart';
import 'package:alo_doctor_doctor/utils/styles.dart';
import 'package:alo_doctor_doctor/utils/DateFormatter.dart';

import 'package:alo_doctor_doctor/api/login.dart';

class AppointmentDetails extends StatefulWidget {
  final String Name;
  final String pId;
  final String time;
  final String date;
  final String email;
  final String number;
  final String path;
  final String bookingId;
  final int bookingStatus;
  List prescriptionList;

  AppointmentDetails({
    this.time,
    this.date,
    this.Name,
    this.number,
    this.email,
    this.pId,
    this.path,
    this.bookingId,
    this.bookingStatus,
    this.prescriptionList,
  });

  @override
  _AppointmentDetailsState createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  var bookingDetails;
  bool _isLoading = false;

  void setData(String bookingId) async {
    print('hey');
    await LoginCheck()
        .getBookingsById(int.parse(widget.bookingId))
        .then((value) {
      setState(() {
        bookingDetails = value[0];
        widget.prescriptionList = value[0]["prescription"];
        _isLoading = false;
      });
    });
  }

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    setData(widget.bookingId);

    super.initState();
  }

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
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Icon(Icons.notifications_none),
        //   ),
        // ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              backgroundColor: Colors.grey.shade800,
              color: Colors.white,
              onRefresh: () async {
                // print('hey');
                // await LoginCheck()
                //     .getBookingsById(int.parse(widget.bookingId))
                //     .then((value) {
                //   setState(() {
                //     widget.prescriptionList = value[0]["prescription"];
                //   });
                // });
                setData(widget.bookingId);
              },
              child: ListView(
                physics: const PageScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                // crossAxisAlignment: CrossAxisAlignment.start,
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
                              backgroundImage: widget.path == null
                                  ? AssetImage('assets/images/userdash.png')
                                  : NetworkImage(
                                      'https://developers.thegraphe.com/alodoctor/public${widget.path}'),
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
                                    widget.Name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
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
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // InkWell(
                        //   child: Container(
                        //     height: 65,
                        //     width: 65,
                        //     padding: const EdgeInsets.all(8),
                        //     decoration: BoxDecoration(
                        //         border: Border.all(
                        //             color: Colors.grey, style: BorderStyle.solid),
                        //         borderRadius: BorderRadius.circular(12)),
                        //     child: Image(
                        //       image: AssetImage('./assets/images/phone.png'),
                        //     ),
                        //   ),
                        // ),
                        InkWell(
                          onTap: () {
                            if (widget.bookingStatus == 2) {
                              Fluttertoast.cancel();
                              Fluttertoast.showToast(msg: 'Session is over');
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VideoCallingScreen(
                                        widget.pId, widget.bookingId)),
                              );
                            }
                          },
                          child: Container(
                            height: 65,
                            width: 65,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(12)),
                            child: Image(
                              image: AssetImage(
                                  './assets/images/video-camera.png'),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Prescription(widget.bookingId)),
                            );
                            // if (widget.prescriptionList == null) {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             Prescription(widget.bookingId)),
                            //   );
                            // } else {
                            //   Navigator.of(context).pushNamed(viewPrescription,
                            //       arguments: ViewPrescription(
                            //         prescriptionList: widget.prescriptionList,
                            //         bookingId: widget.bookingId,
                            //       ));
                            // }
                          },
                          child: Container(
                            height: 65,
                            width: 65,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(12)),
                            child: Image(
                              image: AssetImage('./assets/images/pupload.png'),
                              color: Color.fromRGBO(140, 143, 165, 1),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (bookingDetails["reports"] == null) {
                              Fluttertoast.cancel();
                              Fluttertoast.showToast(msg: 'Report Unavailable');
                            } else {
                              Navigator.of(context).pushNamed(viewReport,
                                  arguments: ViewReport(
                                    reportList: bookingDetails["reports"],
                                    rDescription:
                                        bookingDetails["report_description"],
                                  ));
                            }
                          },
                          child: Container(
                            height: 65,
                            width: 65,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(12)),
                            child: Image(
                              height: 10,
                              color: Color.fromRGBO(140, 143, 165, 1),
                              image: AssetImage('./assets/images/report.png'),
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
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(
                  //       horizontal: 30.0, vertical: 10),
                  //   child: Text(
                  //     'Upcoming',
                  //     style: TextStyle(
                  //         color: Colors.black,
                  //         fontSize: 15,
                  //         fontWeight: FontWeight.w700),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
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
                              widget.date,
                              style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              widget.time,
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

                  Divider(
                    thickness: 1,
                    color: Color(0xff8C8FA5),
                  ),
                  if (bookingDetails["call_history"].isNotEmpty)
                    Container(
                      // color: Colors.blue,
                      padding: const EdgeInsets.only(left: 30, top: 2),
                      height: 30,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            Container(
                              // color: Colors.red,
                              height: 20,
                              width: 20,
                              child: Image(
                                image: AssetImage('./assets/images/clock.png'),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Call History",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (bookingDetails["call_history"].isNotEmpty)
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: ListView.builder(
                          itemCount: bookingDetails["call_history"].length,
                          itemBuilder: (context, index) {
                            print(
                                bookingDetails["call_history"][index]["start"]);
                            return Container(
                              // color: Colors.blue,
                              padding: const EdgeInsets.only(left: 30, top: 5),
                              height: 47,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // color: Colors.red,
                                    height: 20,
                                    width: 20,
                                    child: Icon(Icons.video_call,
                                        color: lightGrey, size: 20),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        DateFormatter()
                                            .getVerboseDateTimeRepresentation(
                                                DateTime.parse(bookingDetails[
                                                        "call_history"][index]
                                                    ["start"])),
                                        style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        bookingDetails["call_history"][index]
                                            ["duration"],
                                        style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                    )
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
            ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 0.0),
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 10.0),
      //     child: Row(
      //       children: [
      //         Expanded(
      //           child: InkWell(
      //             onTap: () {
      //               bottomSheet();
      //             },
      //             child: Container(
      //               height: 50,
      //               decoration: BoxDecoration(
      //                 color: Color(0xffDFF4F3),
      //                 borderRadius: BorderRadius.circular(10),
      //               ),
      //               child: Padding(
      //                 padding: const EdgeInsets.symmetric(
      //                   horizontal: 10.0,
      //                 ),
      //                 child: Center(
      //                   child: Text('Reschedule',
      //                       style: TextStyle(
      //                           fontSize: 15,
      //                           color: Colors.black87,
      //                           fontWeight: FontWeight.w600)),
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ),
      //         // SizedBox(
      //         //   width: 30,
      //         // ),
      //         // Expanded(
      //         //   child: Container(
      //         //     height: 40,
      //         //     decoration: BoxDecoration(
      //         //         border: Border.all(color: Color(0xffDFF4F3), width: 1),
      //         //         color: Colors.white,
      //         //         borderRadius: BorderRadius.circular(10)),
      //         //     child: Padding(
      //         //       padding: const EdgeInsets.symmetric(
      //         //         horizontal: 10.0,
      //         //       ),
      //         //       child: Center(
      //         //         child: Text('Cancel Appointment',
      //         //             overflow: TextOverflow.ellipsis,
      //         //             style: TextStyle(
      //         //                 fontSize: 15,
      //         //                 color: Colors.black87,
      //         //                 fontWeight: FontWeight.w600)),
      //         //       ),
      //         //     ),
      //         //   ),
      //         // ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  void bottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return RescheduleBooking();
        });
  }

}
