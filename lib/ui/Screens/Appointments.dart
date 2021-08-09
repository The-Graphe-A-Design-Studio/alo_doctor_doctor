import 'package:alo_doctor_doctor/utils/Colors.dart';
import 'package:alo_doctor_doctor/utils/MyConstants.dart';
import 'package:alo_doctor_doctor/widgets/AppointmentMini.dart';
import 'package:flutter/material.dart';

class Appointments extends StatefulWidget {
  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  List<Modal> appointList = [];
  bool select = false;
  @override
  void initState() {
    appointList.add(Modal(
        name: 'Akash Bose',
        time: '4:30',
        date: '03 Aug, 2021',
        isSelected: false));
    appointList.add(Modal(
        name: 'Priya shetty',
        time: '5:30',
        date: '03 Aug, 2021',
        isSelected: false));
    appointList.add(Modal(
        name: 'Pooja Bhel',
        time: '6:30',
        date: '03 Aug, 2021',
        isSelected: false));
    appointList.add(Modal(
        name: 'Akash Bose',
        time: '4:30',
        date: '03 Aug, 2021',
        isSelected: false));
    appointList.add(Modal(
        name: 'Priya shetty',
        time: '5:30',
        date: '03 Aug, 2021',
        isSelected: false));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
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
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.notifications_none),
          ),
        ],
        title: Column(
          children: [
            Text(
              'Appointments',
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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(33.0, 20.0, 33.0, 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '09 January,Saturday',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff8c8fa5)),
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                'Today',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: appointList.length,
                  itemBuilder: (context, index) {
                    return AppointmentMini(
                        time: appointList[index].time,
                        Name: appointList[index].name,
                        date: appointList[index].date,
                        isSelected: appointList[index].isSelected,
                        onTap: () {
                          setState(() {
                            appointList.forEach((element) {
                              element.isSelected = false;
                            });

                            appointList[index].isSelected = true;
                          });
                          appointList.forEach((element) {
                            if (element.isSelected) {
                              select = true;
                            }
                            print(element.isSelected);
                          });
                        });
                  }),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () {
          if (select) {
            Navigator.pushNamed(context, appointmentDetails);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Container(
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(
                color: select ? Color(0xffE9F98F) : Color(0xffDFF4F3),
                border: Border.all(
                    color: select ? Color(0xffE9F98F) : Color(0xffDFF4F3),
                    width: 1),
                borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: Text('Continue',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600))),
          ),
        ),
      ),
    );
  }
}

class Modal {
  String name;
  String time;
  String date;
  bool isSelected;

  Modal({this.name, this.isSelected = false, this.time, this.date});
}
