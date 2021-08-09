import 'dart:io';

import 'package:alo_doctor_doctor/api/login.dart';
import 'package:alo_doctor_doctor/utils/Colors.dart';
import 'package:alo_doctor_doctor/utils/MyConstants.dart';
import 'package:alo_doctor_doctor/utils/form_validator.dart';
import 'package:alo_doctor_doctor/widgets/customButton.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isLoading = false;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
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
        int doc = await LoginCheck()
            .UserLogin(_authData['email'], _authData['password']);
        if (doc == 1) {
          print('logged');

          Navigator.pushReplacementNamed(context, homePage, arguments: doc);
        } else {
          throw HttpException('Invalid email or password!');
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
                    onPressed: () {
                      Navigator.pushNamed(context, signUp);
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
