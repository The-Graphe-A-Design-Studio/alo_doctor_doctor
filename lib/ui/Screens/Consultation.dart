import 'package:alo_doctor_doctor/utils/Colors.dart';
import 'package:alo_doctor_doctor/utils/MyConstants.dart';
import 'package:flutter/material.dart';

class Consultation extends StatefulWidget {
  @override
  _ConsultationState createState() => _ConsultationState();
}

class _ConsultationState extends State<Consultation> {
  int select = 0;
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
              'Consultations',
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
          padding: const EdgeInsets.fromLTRB(33.0, 30.0, 33.0, 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    select = 1;
                  });
                },
                child: Container(
                    height: 51,
                    decoration: BoxDecoration(
                        color: select == 1 ? Color(0xffE9F98F) : Colors.white,
                        border: Border.all(color: Color(0xff000000), width: 1),
                        borderRadius: BorderRadius.circular(20),
                        shape: BoxShape.rectangle,
                        // BoxShape.circle or BoxShape.retangle
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.04),
                              blurRadius: 4.0,
                              offset: Offset(0, 4)),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        children: [
                          Image(
                            image: AssetImage('assets/images/callogo.png'),
                            height: 30,
                            width: 30,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Schedule Consultations',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Expanded(child: Container()),
                          RotatedBox(
                            quarterTurns: 2,
                            child: Image(
                              image: AssetImage(
                                'assets/images/planeArrow.png',
                              ),
                              height: 20.0,
                              width: 20.0,
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    select = 2;
                  });
                },
                child: Container(
                    height: 51,
                    decoration: BoxDecoration(
                        color: select == 2 ? Color(0xffE9F98F) : Colors.white,
                        border: Border.all(color: Color(0xff000000), width: 1),
                        borderRadius: BorderRadius.circular(20),
                        shape: BoxShape.rectangle,
                        // BoxShape.circle or BoxShape.retangle
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.04),
                              blurRadius: 4.0,
                              offset: Offset(0, 4)),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Image(
                            image: AssetImage('assets/images/credit.png'),
                            height: 30,
                            width: 30,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Set Consultation fee',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Expanded(child: Container()),
                          RotatedBox(
                            quarterTurns: 2,
                            child: Image(
                              image: AssetImage(
                                'assets/images/planeArrow.png',
                              ),
                              height: 20.0,
                              width: 20.0,
                            ),
                          ),
                        ],
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () {
          if (select == 1) {
            Navigator.pushNamed(context, consultSched);
          } else if (select == 2) {
            Navigator.pushNamed(context, consultFee);
          } else {}
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
                color: select == 0 ? Color(0xffDFF4F3) : Color(0xffE9F98F),
                border: Border.all(
                    color: select == 0 ? Color(0xffDFF4F3) : Color(0xffE9F98F),
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
