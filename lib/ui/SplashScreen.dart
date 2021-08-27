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
  bool registered;

  Future<bool> doSomeAction() async {
    await Future.delayed(Duration(seconds: 1), () {});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    String name = prefs.getString("name");
    print(name);
    if (name != null) {
      registered = true;
    } else {
      registered = false;
    }
    if (token != null) {
      // user = User.fromJson(json.decode(prefs.getString("UserData")));
      return true;
    }
    return Future.value(false);
  }

  @override
  void initState() {
    super.initState();
    doSomeAction().then((value) {
      if (value == true) {
        // if (user.success == "1") {
        //   Navigator.pushReplacementNamed(context, homePage, arguments: user);
        // } else {
        //   Navigator.pushReplacementNamed(context, registerPage,
        //       arguments: user);
        // }
        if (registered) {
          Navigator.pushReplacementNamed(context, homePage);
        } else {
          Navigator.pushReplacementNamed(context, registerPage);
        }
      } else {
        Navigator.pushReplacementNamed(context, signIn);
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
              'Doctor',
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
