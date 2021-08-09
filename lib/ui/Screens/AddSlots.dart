import 'dart:convert';

import 'package:alo_doctor_doctor/api/agoraApis.dart';
import 'package:alo_doctor_doctor/models/Slots.dart';
import 'package:alo_doctor_doctor/utils/Colors.dart';
import 'package:alo_doctor_doctor/utils/MyConstants.dart';
import 'package:alo_doctor_doctor/utils/form_validator.dart';
import 'package:alo_doctor_doctor/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:table_calendar/table_calendar.dart';

class AddSlots extends StatefulWidget {
  const AddSlots({Key key}) : super(key: key);

  @override
  _AddSlotsState createState() => _AddSlotsState();
}

enum forTimeEnum { morningFrom, morningTo, eveningFrom, eveningTo }

class _AddSlotsState extends State<AddSlots> {
  bool _isLoading = false;
  String _selectedDates = '';
  List<String> _selectedDate = [];
  TimeOfDay morningFrom = TimeOfDay.now();
  TimeOfDay morningTo = TimeOfDay.now();
  TimeOfDay eveningFrom = TimeOfDay.now();
  TimeOfDay eveningTo = TimeOfDay.now();
  // TimeOfDay morningFrom, morningTo, eveningFrom, eveningTo;
  String interval;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  AgoraApis _agoraApis = AgoraApis();

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is List<DateTime>) {
        // _selectedDates = '';
        _selectedDate = [];

        for (int i = 0; i < args.value.length; i++) {
          _selectedDate
              .add(DateFormat('yyyy-MM-dd').format(args.value[i]).toString());
        }

        // _selectedDates = args.value.toString();
        _selectedDates = _selectedDate.toString();
      }
    });
  }

  Future<void> _selectTime(BuildContext context, forTimeEnum forTime) async {
    if (forTime == forTimeEnum.morningFrom) {
      final TimeOfDay picked_s = await showTimePicker(
          context: context,
          initialTime: morningFrom,
          builder: (BuildContext context, Widget child) {
            return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
              child: child,
            );
          });

      if (picked_s != null && picked_s != morningFrom)
        setState(() {
          morningFrom = picked_s;
        });
    } else if (forTime == forTimeEnum.morningTo) {
      final TimeOfDay picked_s = await showTimePicker(
          context: context,
          initialTime: morningTo,
          builder: (BuildContext context, Widget child) {
            return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
              child: child,
            );
          });

      if (picked_s != null && picked_s != morningTo)
        setState(() {
          morningTo = picked_s;
        });
    } else if (forTime == forTimeEnum.eveningFrom) {
      final TimeOfDay picked_s = await showTimePicker(
          context: context,
          initialTime: eveningFrom,
          builder: (BuildContext context, Widget child) {
            return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
              child: child,
            );
          });

      if (picked_s != null && picked_s != eveningFrom)
        setState(() {
          eveningFrom = picked_s;
        });
    } else if (forTime == forTimeEnum.eveningTo) {
      final TimeOfDay picked_s = await showTimePicker(
          context: context,
          initialTime: eveningTo,
          builder: (BuildContext context, Widget child) {
            return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
              child: child,
            );
          });

      if (picked_s != null && picked_s != eveningTo)
        setState(() {
          eveningTo = picked_s;
        });
    }
  }

  Iterable<TimeOfDay> getTimes(
      TimeOfDay startTime, TimeOfDay endTime, Duration step) sync* {
    var hour = startTime.hour;
    var minute = startTime.minute;

    do {
      yield TimeOfDay(hour: hour, minute: minute);
      minute += step.inMinutes;
      while (minute >= 60) {
        minute -= 60;
        hour++;
      }
    } while (hour < endTime.hour ||
        (hour == endTime.hour && minute <= endTime.minute));
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  Future<String> _createSlots() async {
    setState(() {
      _isLoading = true;
    });
    try {
      if (_selectedDate.length > 0) {
        if (morningFrom.format(context) != morningTo.format(context)) {
          if (interval != null && interval != '') {
            print(interval);

            if (eveningFrom.format(context) != eveningTo.format(context)) {
              final morningTimes = getTimes(morningFrom, morningTo,
                      Duration(minutes: int.parse(interval)))
                  .map((tod) => tod.format(context))
                  .toList();

              final eveningTimes = getTimes(eveningFrom, eveningTo,
                      Duration(minutes: int.parse(interval)))
                  .map((tod) => tod.format(context))
                  .toList();

              print(morningTimes + eveningTimes);

              List<Slot> slots = [];
              for (int i = 0; i < _selectedDate.length; i++) {
                slots.add(Slot(
                    date: _selectedDate[i],
                    time: (morningTimes + eveningTimes)
                        .toString()
                        .replaceAll('[', '')
                        .replaceAll(']', '')));
              }
              String jsonTags = jsonEncode({'slots': slots});
              print(jsonTags);
              var slotBody = await _agoraApis.createSlots(jsonTags);
              print('SLOT BODY: ' + slotBody.toString());
              setState(() {
                _isLoading = false;
              });
              return slotBody.toString();
            } else {
              final times = getTimes(morningFrom, morningTo,
                      Duration(minutes: int.parse(interval)))
                  .map((tod) => tod.format(context))
                  .toList();

              print(times);

              List<Slot> slots = [];
              for (int i = 0; i < _selectedDate.length; i++) {
                slots.add(Slot(
                    date: _selectedDate[i],
                    time: (times)
                        .toString()
                        .replaceAll('[', '')
                        .replaceAll(']', '')));
              }
              String jsonTags = jsonEncode({'slots': slots});
              print(jsonTags);
              var slotBody = await _agoraApis.createSlots(jsonTags);
              print('SLOT BODY: ' + slotBody.toString());
              setState(() {
                _isLoading = false;
              });
              return slotBody.toString();
            }
          } else {
            setState(() {
              _isLoading = false;
            });
            showInSnackBar('Please select Time Interval');
            return null;
          }
        } else {
          setState(() {
            _isLoading = false;
          });
          showInSnackBar('At least morning should be selected');
          return null;
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        showInSnackBar('Please select Dates');
        return null;
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Image(
              image: AssetImage(
                'assets/images/arrow.png',
              ),
              height: 18.0,
              width: 30.0,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Column(
          children: [
            Text(
              'Create Slots',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
        centerTitle: true,
        backgroundColor: accentBlueLight,
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SfDateRangePicker(
              onSelectionChanged: _onSelectionChanged,
              selectionMode: DateRangePickerSelectionMode.multiple,
              minDate: DateTime.now(),
              maxDate: DateTime.now().add(const Duration(days: 6)),
              selectionColor: Color(0xFFECF89C),
              selectionTextStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
              headerStyle: DateRangePickerHeaderStyle(
                  textStyle: TextStyle(color: Colors.black87, fontSize: 16)),
              // initialSelectedRange: PickerDateRange(
              //     DateTime.now().subtract(const Duration(days: 4)),
              //     DateTime.now().add(const Duration(days: 3))),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Selected date count: ',
                style: TextStyle(color: Colors.black87, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                _selectedDates,
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Morning Shift: ',
                style: TextStyle(color: Colors.black87, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _selectTime(context, forTimeEnum.morningFrom);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xFFECF89C),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'From: ' + morningFrom.format(context),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '-',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _selectTime(context, forTimeEnum.morningTo);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xFFECF89C),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'To: ' + morningTo.format(context),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Evening Shift: ',
                style: TextStyle(color: Colors.black87, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _selectTime(context, forTimeEnum.eveningFrom);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xFFECF89C),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'From: ' + eveningFrom.format(context),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '-',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _selectTime(context, forTimeEnum.eveningTo);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xFFECF89C),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'To: ' + eveningTo.format(context),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Time Interval: (in Min)',
                style: TextStyle(color: Colors.black87, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'Interval',
                    border: OutlineInputBorder(),
                    suffixText: 'min'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  interval = value;
                },
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: CustomButton(
                  btnText: 'Create Slots',
                  backgroundColor: accentBlueLight,
                  btnWidth: 100,
                  onPressed: () async {
                    try {
                      if (_isLoading) showLoaderDialog(context);

                      var data = await _createSlots();
                      if (data != null) {
                        // Navigator.of(context).pushNamedAndRemoveUntil(consultSched, ModalRoute.withName(consultSched));
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                        // showAboutDialog(context: context);
                      }
                    } catch (e) {
                      showInSnackBar(
                          'Something went wrong, Please try again later.');
                    }
                  }),
            ),
            SizedBox(
              height: 32,
            ),
          ],
        ),
      ),
    );
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7),
              child: Text("Creating Slots...")),
        ],
      ),
    );

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
