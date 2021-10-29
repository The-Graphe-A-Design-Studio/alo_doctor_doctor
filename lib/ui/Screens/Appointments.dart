import 'package:intl/intl.dart';

import 'package:alo_doctor_doctor/api/login.dart';
import 'package:alo_doctor_doctor/ui/Screens/AppointmentDetailScreen.dart';
import 'package:alo_doctor_doctor/utils/Colors.dart';
import 'package:alo_doctor_doctor/utils/MyConstants.dart';
import 'package:alo_doctor_doctor/utils/styles.dart';
import 'package:alo_doctor_doctor/widgets/AppointmentMini.dart';
import 'package:flutter/material.dart';

class Appointments extends StatefulWidget {
  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  List<Modal> upcomingList = List<Modal>.empty(growable: true);
  List<Modal> historyList = List<Modal>.empty(growable: true);

  bool select = false;
  String number;
  String email;
  List pList;
  bool _isLoading = false;

  Future<void> setData() async {
    var data = await LoginCheck().getMyBookings();

    setState(() {
      historyList.clear();
      upcomingList.clear();
      data.forEach((appointment) {
        if (appointment["status"] != 2 &&
            DateTime.parse(appointment["slot_date_time"])
                    .compareTo(DateTime.now()) >=
                0) {
          upcomingList.add(Modal(
            name: appointment["patient"]["name"],
            pId: appointment["patient"]["id"].toString(),
            time: appointment["slot_time"],
            profile: appointment["patient"]["profile_pic_path"],
            date: appointment["slot_date"],
            id: appointment["id"],
            isSelected: false,
            bookingStatus: appointment["status"],
          ));
          upcomingList.sort((a, b) =>
              DateTime.parse(a.date + " " + a.time.split(" ")[0]).compareTo(
                  DateTime.parse(b.date + " " + b.time.split(" ")[0])));
          // appointList = appointList.reversed.toList();
        } else {
          historyList.add(Modal(
            name: appointment["patient"]["name"],
            pId: appointment["patient"]["id"].toString(),
            time: appointment["slot_time"],
            profile: appointment["patient"]["profile_pic_path"],
            date: appointment["slot_date"],
            id: appointment["id"],
            isSelected: false,
            bookingStatus: appointment["status"],
          ));
          historyList.sort((a, b) =>
              DateTime.parse(a.date + " " + a.time.split(" ")[0]).compareTo(
                  DateTime.parse(b.date + " " + b.time.split(" ")[0])));
          historyList = historyList.reversed.toList();
        }
      });

      _isLoading = false;
    });
  }

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    setData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
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
          title: Text(
            'Appointments',
            style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          backgroundColor: accentBlueLight,
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    height: 50,
                    child: AppBar(
                      elevation: 0,
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      bottom: TabBar(
                        indicatorWeight: 2,
                        indicatorColor: accentYellow,
                        labelColor: Colors.black,
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        tabs: <Widget>[
                          Tab(
                            text: 'Upcoming',
                          ),
                          Tab(
                            text: 'History',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        RefreshIndicator(
                          backgroundColor: Colors.grey.shade800,
                          color: Colors.white,
                          onRefresh: setData,
                          child: upcomingList.isEmpty
                              ? Center(
                                  child: Text(
                                    "No upcoming appointments",
                                    style: Styles.buttonTextBlackBold,
                                  ),
                                )
                              : ListView.builder(
                                  padding: const EdgeInsets.fromLTRB(
                                      33.0, 20.0, 33.0, 10),
                                  shrinkWrap: true,
                                  // physics: NeverScrollableScrollPhysics(),
                                  itemCount: upcomingList.length,
                                  itemBuilder: (context, index) {
                                    return AppointmentMini(
                                        path: upcomingList[index].profile,
                                        time: upcomingList[index].time,
                                        Name: upcomingList[index].name,
                                        date: upcomingList[index].date,
                                        isSelected:
                                            upcomingList[index].isSelected,
                                        onTap: () async {
                                          await LoginCheck()
                                              .getBookingsById(
                                                  upcomingList[index].id)
                                              .then((value) {
                                            value.forEach((appointment) {
                                              setState(() {
                                                number = appointment["patient"]
                                                        ["phone"]
                                                    .toString();
                                                email = appointment["patient"]
                                                    ["email"];
                                                pList =
                                                    appointment["prescription"];
                                              });
                                            });
                                          });
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AppointmentDetails(
                                                      bookingId:
                                                          upcomingList[index]
                                                              .id
                                                              .toString(),
                                                      bookingStatus:
                                                          upcomingList[index]
                                                              .bookingStatus,
                                                      time: upcomingList[index]
                                                          .time,
                                                      date: upcomingList[index]
                                                          .date,
                                                      Name: upcomingList[index]
                                                          .name,
                                                      number: number,
                                                      email: email,
                                                      pId: upcomingList[index]
                                                          .pId
                                                          .toString(),
                                                      path: upcomingList[index]
                                                          .profile,
                                                      prescriptionList: pList,
                                                    )),
                                          );
                                        });
                                  }),
                        ),
                        RefreshIndicator(
                          backgroundColor: Colors.grey.shade800,
                          color: Colors.white,
                          onRefresh: setData,
                          child: historyList.isEmpty
                              ? Center(
                                  child: Text(
                                    "You have no appointments!",
                                    style: Styles.buttonTextBlackBold,
                                  ),
                                )
                              : ListView.builder(
                                  padding: const EdgeInsets.fromLTRB(
                                      33.0, 20.0, 33.0, 10),
                                  shrinkWrap: true,
                                  // physics: NeverScrollableScrollPhysics(),
                                  itemCount: historyList.length,
                                  itemBuilder: (context, index) {
                                    return AppointmentMini(
                                        path: historyList[index].profile,
                                        time: historyList[index].time,
                                        Name: historyList[index].name,
                                        date: historyList[index].date,
                                        isSelected:
                                            historyList[index].isSelected,
                                        onTap: () async {
                                          await LoginCheck()
                                              .getBookingsById(
                                                  historyList[index].id)
                                              .then((value) {
                                            value.forEach((appointment) {
                                              setState(() {
                                                number = appointment["patient"]
                                                        ["phone"]
                                                    .toString();
                                                email = appointment["patient"]
                                                    ["email"];
                                                pList =
                                                    appointment["prescription"];
                                              });
                                            });
                                          });
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AppointmentDetails(
                                                      bookingId:
                                                          historyList[index]
                                                              .id
                                                              .toString(),
                                                      bookingStatus:
                                                          historyList[index]
                                                              .bookingStatus,
                                                      time: historyList[index]
                                                          .time,
                                                      date: historyList[index]
                                                          .date,
                                                      Name: historyList[index]
                                                          .name,
                                                      number: number,
                                                      email: email,
                                                      pId: historyList[index]
                                                          .pId
                                                          .toString(),
                                                      path: historyList[index]
                                                          .profile,
                                                      prescriptionList: pList,
                                                    )),
                                          );
                                        });
                                  }),
                        ),
                      ],
                    ),
                  )
                ],
              ),

        // *****************
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [

        //     Expanded(
        //       child: ListView.builder(
        //           padding:
        //               const EdgeInsets.fromLTRB(33.0, 20.0, 33.0, 10),
        //           shrinkWrap: true,
        //           // physics: NeverScrollableScrollPhysics(),
        //           itemCount: appointList.length,
        //           itemBuilder: (context, index) {
        //             return AppointmentMini(
        //                 path: appointList[index].profile,
        //                 time: appointList[index].time,
        //                 Name: appointList[index].name,
        //                 date: appointList[index].date,
        //                 isSelected: appointList[index].isSelected,
        //                 onTap: () async {
        //                   await LoginCheck()
        //                       .getBookingsById(appointList[index].id)
        //                       .then((value) {
        //                     value.forEach((appointment) {
        //                       setState(() {
        //                         number = appointment["patient"]
        //                                 ["phone"]
        //                             .toString();
        //                         email =
        //                             appointment["patient"]["email"];
        //                         pList = appointment["prescription"];
        //                       });
        //                     });
        //                   });
        //                   Navigator.push(
        //                     context,
        //                     MaterialPageRoute(
        //                         builder: (context) =>
        //                             AppointmentDetails(
        //                               bookingId: appointList[index]
        //                                   .id
        //                                   .toString(),
        //                               bookingStatus:
        //                                   appointList[index]
        //                                       .bookingStatus,
        //                               time: appointList[index].time,
        //                               date: appointList[index].date,
        //                               Name: appointList[index].name,
        //                               number: number,
        //                               email: email,
        //                               pId: appointList[index]
        //                                   .pId
        //                                   .toString(),
        //                               path:
        //                                   appointList[index].profile,
        //                               prescriptionList: pList,
        //                             )),
        //                   );

        //                 });
        //           }),
        //     ),
        //   ],
        // ),
      ),
      //
    );
  }
}

class Modal {
  String name;
  String pId;
  String time;
  String date;
  bool isSelected;
  String profile;
  int id;
  int bookingStatus;
  Modal({
    this.name,
    this.pId,
    this.isSelected = false,
    this.time,
    this.profile,
    this.date,
    this.id,
    this.bookingStatus,
  });
}
