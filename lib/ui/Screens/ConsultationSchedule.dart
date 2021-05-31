import 'package:alo_doctor_doctor/utils/Colors.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/slotModel.dart';
import '../../utils/Colors.dart';
import '../../utils/MyConstants.dart';
import '../../widgets/slotItem.dart';

class ConsultationSchedule extends StatefulWidget {
  @override
  _ConsultationScheduleState createState() => _ConsultationScheduleState();
}

class _ConsultationScheduleState extends State<ConsultationSchedule> {
  String selectedDate = DateFormat.MMMMEEEEd().format(DateTime.now());
  bool _isMorningSelected = false;
  bool _isEveningSelected = true;
  bool forward = false;

  final List morningSlots = SlotModel.morningSlots;
  final List eveningSlots = SlotModel.eveningSlots;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 15),
                  child: Text(
                    selectedDate,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: CalendarTimeline(
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                    onDateSelected: (date) =>
                        {selectedDate = DateFormat.MMMMEEEEd().format(date)},
                    leftMargin: 20,
                    monthColor: Colors.black,
                    dayColor: Colors.grey,
                    dayNameColor: Color(0xFF333A47),
                    activeDayColor: Colors.black,
                    activeBackgroundDayColor: accentBlueLight,
                    dotsColor: accentBlueLight,
                    // selectableDayPredicate: (date) => date.day != 23,
                    locale: 'en_US',
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            _isMorningSelected = true;
                            _isEveningSelected = false;
                          });
                        },
                        child: Container(
                          width: 150,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            color: _isMorningSelected
                                ? accentYellow
                                : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Image(
                                  image: AssetImage(
                                      './assets/images/morning.png')),
                              SizedBox(
                                width: 18,
                              ),
                              Text(
                                'Morning',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _isEveningSelected = true;
                            _isMorningSelected = false;
                          });
                        },
                        child: Container(
                          width: 150,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            color: _isEveningSelected
                                ? accentYellow
                                : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Image(
                                  image: AssetImage(
                                      './assets/images/evening.png')),
                              SizedBox(
                                width: 18,
                              ),
                              Text(
                                'Evening',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 4, left: 20, right: 20),
                  height: 200,
                  width: double.infinity,
                  child: Center(
                    child: GridView.builder(
                        itemCount: _isMorningSelected
                            ? morningSlots.length
                            : eveningSlots.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 7 / 3,
                            crossAxisCount: 3,
                            crossAxisSpacing: 2),
                        itemBuilder: (context, index) {
                          return InkWell(
                            child: _isMorningSelected
                                ? SlotItem(morningSlots[index].isSelected,
                                    morningSlots[index].time)
                                : SlotItem(eveningSlots[index].isSelected,
                                    eveningSlots[index].time),
                            onTap: () {
                              setState(() {
                                if (_isMorningSelected) {
                                  morningSlots.forEach((slot) {
                                    slot.isSelected = false;
                                  });

                                  // because I'm assuming user can select only one slot either one in the morning or one in the evening
                                  eveningSlots.forEach((slot) {
                                    slot.isSelected = false;
                                  });

                                  morningSlots[index].isSelected = true;
                                }

                                if (_isEveningSelected) {
                                  eveningSlots.forEach((slot) {
                                    slot.isSelected = false;
                                  });
                                  morningSlots.forEach((slot) {
                                    slot.isSelected = false;
                                  });
                                  eveningSlots[index].isSelected = true;
                                }
                                forward = true;
                              });
                            },
                          );
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    children: [
                      Text('Edit'),
                      Expanded(child: Container()),
                      Text('Add Slot')
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, paymentScreen);
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
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  width: double.infinity,
                  child: Text(
                    'Continue',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
