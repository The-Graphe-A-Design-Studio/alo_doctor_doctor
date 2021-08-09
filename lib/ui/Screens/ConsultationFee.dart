import 'package:alo_doctor_doctor/utils/Colors.dart';
import 'package:flutter/material.dart';

class ConsultationFee extends StatefulWidget {
  @override
  _ConsultationFeeState createState() => _ConsultationFeeState();
}

class _ConsultationFeeState extends State<ConsultationFee> {
  int selectedWidget;
  int select = 0;
  Widget getConsultMode() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                select = 1;
              });
            },
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: select == 1 ? Color(0xffE9F98F) : Colors.white,
                  border: Border.all(
                      color:
                          select == 1 ? Color(0xffE9F98F) : Color(0xffDFF4F3),
                      width: 1),
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                  child: Text(
                'Voice Calls',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
              )),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                select = 2;
              });
            },
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: select == 2 ? Color(0xffE9F98F) : Colors.white,
                  border: Border.all(
                      color:
                          select == 2 ? Color(0xffE9F98F) : Color(0xffDFF4F3),
                      width: 1),
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                  child: Text(
                'Video Calls',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
              )),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                select = 3;
              });
            },
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: select == 3 ? Color(0xffE9F98F) : Colors.white,
                  border: Border.all(
                      color:
                          select == 3 ? Color(0xffE9F98F) : Color(0xffDFF4F3),
                      width: 1),
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                  child: Text(
                'In Clinic/Offline',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
              )),
            ),
          )
        ],
      ),
    );
  }

  Widget getConsultFee() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            select == 1 ? 'Voice' : (select == 2 ? 'Video' : 'Offline'),
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
          )
        ],
      ),
    );
  }

  Widget getCustomWidget() {
    switch (selectedWidget) {
      case 0:
        return getConsultMode();
      case 1:
        return getConsultFee();
    }
    return getConsultMode();
  }

  @override
  void initState() {
    selectedWidget = 0;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Consultations Fee',
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
            if (selectedWidget == 1) {
              setState(() {
                selectedWidget = 0;
              });
            } else {
              Navigator.of(context).pop();
            }
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
      backgroundColor: Colors.white,
      body: getCustomWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () {
          if (select != 0) {
            setState(() {
              selectedWidget = 1;
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Container(
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(
                color: select != 0 ? Color(0xffE9F98F) : Color(0xffDFF4F3),
                border: Border.all(
                    color: select != 0 ? Color(0xffE9F98F) : Color(0xffDFF4F3),
                    width: 1),
                borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: Text(selectedWidget == 0 ? 'Continue' : 'Done',
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
