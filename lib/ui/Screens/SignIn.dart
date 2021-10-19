import 'dart:io';

import 'package:alo_doctor_doctor/api/login.dart';
import 'package:alo_doctor_doctor/utils/Colors.dart';
import 'package:alo_doctor_doctor/utils/MyConstants.dart';
import 'package:alo_doctor_doctor/utils/form_validator.dart';
import 'package:alo_doctor_doctor/widgets/customButton.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // FirebaseMessaging fcm = FirebaseMessaging.instance;
  // String dtoken;
  bool _isLoading = false;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  @override
  void initState() {
    // fcm.getToken().then((value) => print(value));
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey();
  _showSnackBar(msg, context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        textColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    ));
  }

  Map<String, String> _loginData = {
    'email': '',
    'password': '',
  };

  _submitLogin() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        _isLoading = true;
      });
      try {
        var response = await LoginCheck()
            .UserLogin(_authData['email'], _authData['password']);
        print(response["success"]);
        if (response["success"] != 0) {
          print('logged');
          // bool registered;
          // SharedPreferences prefs = await SharedPreferences.getInstance();
          // String name = prefs.getString("name");
          // print(name);
          // if (name != null) {
          //   registered = true;
          // } else {
          //   registered = false;
          // }
          if (response['update'] != null) {
            Navigator.pushReplacementNamed(
              context,
              homePage,
            );
          } else {
            Navigator.pushReplacementNamed(
              context,
              registerPage,
            );
          }
          // if (registered) {
          //   Navigator.pushReplacementNamed(context, homePage, arguments: doc);
          // } else {
          //   Navigator.pushReplacementNamed(context, registerPage);
          // }
        } else {
          throw HttpException(response['error']);
        }
      } catch (e) {
        _showSnackBar('Invalid email or password!', context);
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.only(top: 60, left: 35, right: 35),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Hero(
                    tag: "Logo",
                    child: Image(
                      image: AssetImage('assets/images/alo_logo.png'),
                      height: 250.0,
                      width: 250.0,
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'E-mail'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => FormValidator.validateEmail(value),
                    onChanged: (value) {
                      _authData['email'] = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) => FormValidator.validatePassword(value),
                    onChanged: (value) {
                      _authData['password'] = value;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _isLoading
                      ? CircularProgressIndicator()
                      : CustomButton(
                          btnText: 'Login',
                          backgroundColor: accentBlueLight,
                          btnWidth: 100,
                          onPressed: () {
                            _submitLogin();
                          }),
                  TextButton(
                    child: Text(
                      'Signup instead',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () async {
                      Navigator.pushReplacementNamed(context, signUp);
                    },
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(accentBlueLight),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                      ),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
