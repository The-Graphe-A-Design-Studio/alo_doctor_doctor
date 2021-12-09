import 'dart:io';

import 'package:alo_doctor_doctor/api/login.dart';
import 'package:alo_doctor_doctor/ui/RegisterPage.dart';
import 'package:alo_doctor_doctor/utils/Colors.dart';
import 'package:alo_doctor_doctor/utils/MyConstants.dart';
import 'package:flutter/material.dart';

import '../../utils/form_validator.dart';
import '../../widgets/customButton.dart';
import 'package:alo_doctor_doctor/ui/Screens/WebView.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _passwordController = TextEditingController();
  Map<String, dynamic> registerData = {
    'email': '',
    'password': '',
  };
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

  Future _submitSignUp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        _isLoading = true;
      });

      try {
        int doc = await LoginCheck()
            .UserSignUp(registerData['email'], registerData['password']);
        print(doc == 1);
        if (doc == 1) {
          print('logged');
          // await LoginCheck().getSub("Physiotherapy");
          Navigator.pushReplacementNamed(context, registerPage,
              arguments: RegisterPage(false));
        } else {
          throw HttpException('User with this email already exist.');
        }
      } catch (e) {
        _showSnackBar(
            e.message == "Unauthorised"
                ? 'Invalid email or password'
                : 'User found already',
            context);
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showErrorDialogue(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occured!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(_isLoading);
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
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
                        image: AssetImage('assets/images/alo-logo.jpg'),
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.width * 0.58,
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'E-mail'),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (value) => FormValidator.validateEmail(value),
                      onChanged: (value) {
                        registerData['email'] = value;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                      controller: _passwordController,
                      validator: (value) =>
                          FormValidator.validatePassword(value),
                      onChanged: (value) {
                        registerData['password'] = value;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        decoration:
                            InputDecoration(labelText: 'Confirm Password'),
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _submitSignUp(),
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return 'Password do not Match';
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    _isLoading
                        ? CircularProgressIndicator()
                        : CustomButton(
                            btnText: 'Sign up',
                            backgroundColor: accentBlueLight,
                            btnWidth: 100,
                            // onPressed: () async {
                            //   if (_formKey.currentState.validate()) {
                            //     _formKey.currentState.save();
                            //     setState(() {
                            //       widget._isLoading = true;
                            //       print('loading....');
                            //     });

                            //     await _submitSignUp();

                            //     Navigator.pushNamed(context, registerPage);
                            //     setState(() {
                            //       widget._isLoading = false;
                            //     });
                            //   } else
                            //     return null;
                            // },
                            onPressed: _submitSignUp),
                    TextButton(
                      child: Text(
                        'Already have an account',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, signIn);
                      },
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(accentBlueLight),
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
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, webView,
                        arguments: WebViewLoad("Privacy Policy",
                            "https://alodoctor-care.com/privacy-policy-for-app/"));
                  },
                  child: Text("Privacy"),
                ),
                Text("|"),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, webView,
                        arguments: WebViewLoad("Terms & Conditions",
                            "https://alodoctor-care.com/terms-conditions-for-app/"));
                  },
                  child: Text("Terms"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
