import 'dart:convert';

import 'package:alo_doctor_doctor/api/agoraApis.dart';
import 'package:alo_doctor_doctor/models/ServerSlots.dart';
import 'package:alo_doctor_doctor/utils/Colors.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/ServerSlots.dart';
import '../../models/Slots.dart' as slotsModel;
import '../../models/slotModel.dart';
import '../../utils/Colors.dart';
import '../../utils/MyConstants.dart';
import '../../widgets/slotItem.dart';

class ConsultationSchedule extends StatefulWidget {
  @override
  _ConsultationScheduleState createState() => _ConsultationScheduleState();
}

class _ConsultationScheduleState extends State<ConsultationSchedule> {
  String selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  bool forward = false;
  DateTime calenderDate = DateTime.now();
  String error;
  int selectedDateInt = 0;

  final List dummySlots = SlotModel.dummySlots;

  AgoraApis _agoraApis = new AgoraApis();
  ServerSlots slots = new ServerSlots();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    getSlots();
  }

  Future getSlots() async {
    try {
      var data = await _agoraApis.getSlots();
      setState(() {
        slots = data;
      });
      print(slots.slots[0].slotDate.toString());

      print(slots.slots
          .indexWhere((element) => element.slotDate == '2021-08-08'));
      setState(() {
        selectedDateInt = slots.slots.indexWhere(
            (element) => element.slotDate == selectedDate.toString());
      });
    } catch (e) {
      setState(() {
        error = e.toString();
      });
      throw e;
    }
  }

  void setDate() {
    setState(() {
      selectedDateInt = slots.slots
          .indexWhere((element) => element.slotDate == selectedDate.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Consultations',
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
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, addSlotes).then((value) {
                  getSlots();
                });
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: slots.slots != null
          ? Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 30, top: 15),
                      //   child: Text(
                      //     selectedDate,
                      //     style: TextStyle(
                      //         color: Colors.black,
                      //         fontSize: 18,
                      //         fontWeight: FontWeight.w600),
                      //   ),
                      // ),
                      Container(
                        padding: EdgeInsets.all(5),
                        child: CalendarTimeline(
                          initialDate: calenderDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 7)),
                          onDateSelected: (date) {
                            setState(() {
                              selectedDate =
                                  DateFormat('yyyy-MM-dd').format(date);
                              selectedDateInt = slots.slots.indexWhere(
                                  (element) =>
                                      element.slotDate ==
                                      selectedDate.toString());
                              calenderDate = date;
                            });
                          },
                          leftMargin: 20,
                          monthColor: Colors.black,
                          dayColor: Colors.grey,
                          dayNameColor: Color(0xFF333A47),
                          activeDayColor: Colors.black,
                          activeBackgroundDayColor: accentBlueLight,
                          dotsColor: Colors.black87,
                          // selectableDayPredicate: (date) => date.day != 23,
                          locale: 'en_US',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, top: 15),
                        child: Text(
                          'Slots',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      if (selectedDateInt == -1)
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30, top: 15),
                            child: Text(
                              'Oops! No Slots found',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      else
                        Container(
                          margin: const EdgeInsets.only(
                              top: 4, left: 20, right: 20),
                          height: 300,
                          width: double.infinity,
                          child: Center(
                            child: GridView.builder(
                                itemCount: slots
                                    .slots[selectedDateInt].slotTime.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 7 / 3,
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 2),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    child: SlotItem(
                                        slots.slots[selectedDateInt].slotTime[index].status,
                                        slots.slots[selectedDateInt].slotTime[index].time,
                                        false
                                  ),
                                    onTap: () {
                                      showAlertDialog(
                                          context,
                                          slots.slots[selectedDateInt]
                                              .slotTime[index],
                                          index);
                                    },
                                  );
                                }),
                          ),
                        ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: ElevatedButton(
                    onPressed: () {
                      _selectTime(context);
                    },
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (Set<MaterialState> states) {
                          if (forward) return accentYellow;
                          return accentBlueLight;
                        })),
                    child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        width: double.infinity,
                        child: Text(
                          'Add More Slot',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
              ],
            )
          : Center(
              child: error == null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, top: 15),
                          child: Text(
                            'Loading Slots...',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    )
                  : Text(
                      'No Slots Created Yet!',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
            ),
    );
  }

  showAlertDialog(BuildContext context, SlotTime slot, int index) {
    // set up the button
    Widget yesButton = TextButton(
      child: Text("Yes"),
      onPressed: () async {
        var body = await _agoraApis.deleteSlot(slot.id.toString());
        if (body["success"] == 1) {
          setState(() {
            slots.slots[selectedDateInt].slotTime.removeAt(index);
          });
          Navigator.pop(context);
          showInSnackBar('Slot Deleted');
        } else {
          showInSnackBar(body['message']);
        }
      },
    );

    // set up the button
    Widget noButton = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete Slot"),
      content:
          Text("Are you sure you want to delete this (${slot.time}) slot?"),
      actions: [
        noButton,
        yesButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked_s = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });

    if (picked_s != null && picked_s != selectedTime)
      setState(() {
        selectedTime = picked_s;
      });
    print('Time: ' + selectedTime.format(context));
    print('Date: ' + selectedDate);

    List<slotsModel.Slot> slots = [];
    slots.add(slotsModel.Slot(
        date: selectedDate, time: selectedTime.format(context)));
    String jsonTags = jsonEncode({'slots': slots});
    print(jsonTags);
    var slotBody = await _agoraApis.createSlots(jsonTags);
    print('SLOT BODY: ' + slotBody.toString());
    if (slotBody["success"] == 1) {
      showInSnackBar('Slot Created');
      setState(() {});
    } else {
      showInSnackBar(slotBody['message']);
    }
  }
}
