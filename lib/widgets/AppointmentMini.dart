import 'package:flutter/material.dart';

class AppointmentMini extends StatelessWidget {
  final String Name;
  final String time;
  const AppointmentMini({
    this.Name,
    this.time,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Container(
        height: 66,
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Color(0xffDFF4F3), width: 1),
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
          child: Row(
            children: [
              Image(
                image: AssetImage('assets/images/userdash.png'),
                height: 43,
                width: 43,
                fit: BoxFit.fill,
              ),
              SizedBox(
                width: 24,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Name,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                  Text(
                    time + ' PM',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  )
                ],
              ),
              Expanded(child: Container()),
              Image(
                image: AssetImage('assets/images/babydash.png'),
                height: 33,
                width: 22,
                fit: BoxFit.fill,
              ),
              SizedBox(
                width: 32,
              ),
              RotatedBox(
                quarterTurns: 2,
                child: Image(
                  image: AssetImage(
                    'assets/images/planeArrow.png',
                  ),
                  height: 15.0,
                  width: 15.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
