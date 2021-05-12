import 'dart:convert';

import 'package:alo_doctor_doctor/models/doctor.dart';
import 'package:alo_doctor_doctor/utils/MyConstants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Doctor doctor;
  String userType;

  Future<bool> doSomeAction() async {
    await Future.delayed(Duration(seconds: 2), () {});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool rememberMe = prefs.getBool("rememberMe");
    if (rememberMe == true) {
      doctor = Doctor.fromJson(json.decode(prefs.getString("doctorData")));
    }
    return Future.value(rememberMe);
  }

  @override
  void initState() {
    super.initState();
    doSomeAction().then((value) {
      if (value == true) {
        if (doctor.verified == "1") {
          Navigator.pushReplacementNamed(context, homePage, arguments: doctor);
        } else {
          Navigator.pushReplacementNamed(context, registerPage,
              arguments: doctor);
        }
      } else {
        Navigator.pushReplacementNamed(context, loginPage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: "WhiteLogo",
              child: Image(
                image: AssetImage('assets/images/alo_logo.png'),
                height: 200.0,
                width: 200.0,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Alo Doctor - Doctor',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 22.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
