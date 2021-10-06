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

class RescheduleBooking extends StatefulWidget {
  final String bookingId;
  final Function onFinish;
  RescheduleBooking(this.bookingId, this.onFinish);
  @override
  _RescheduleBookingState createState() => _RescheduleBookingState();
}

class _RescheduleBookingState extends State<RescheduleBooking> {
  String selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  bool forward = false;
  DateTime calenderDate = DateTime.now();
  String error;
  int selectedDateInt = 0;

  final List dummySlots = SlotModel.dummySlots;

  AgoraApis _agoraApis = new AgoraApis();
  ServerSlots slots = new ServerSlots();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  SlotTime selectedTime;

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
          'Reschedule Booking',
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
      ),
      body: slots.slots != null
          ? Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
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
                        GridView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: slots.slots[selectedDateInt].slotTime.length,
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
                                    slots.slots[selectedDateInt].slotTime[index].selected,
                                ),
                                onTap: slots.slots[selectedDateInt].slotTime[index].status == 1
                                    ? null
                                    : () {
                                  setState(() {
                                    if (slots.slots[selectedDateInt].slotTime[index].status == 0) {
                                      slots.slots[selectedDateInt].slotTime.forEach((element) {
                                        // if (element.status != 1)
                                        element.selected = false;
                                      });
                                      slots.slots[selectedDateInt].slotTime[index].selected = true;
                                    }
                                  });
                                  selectedTime = slots.slots[selectedDateInt].slotTime[index];
                                  print(selectedDate);
                                  print(selectedTime.time);
                                  print(selectedTime.id);
                                },
                              );
                            }),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: ElevatedButton(
                    onPressed: () {
                      _rescheduleSlot();
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
                          'Reschedule',
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

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(value)));
  }

  void _rescheduleSlot () async {

    if(selectedTime != null) {

      try {
        var data = await _agoraApis.rescheduleBooking(widget.bookingId, selectedTime.id.toString());
        print(data);

        widget.onFinish();
        Navigator.pop(context);

      } catch (e) {
        setState(() {
          error = e.toString();
        });
        throw e;
      }

    } else {
      showInSnackBar('Please Select a slot to continue');
    }

  }
}
