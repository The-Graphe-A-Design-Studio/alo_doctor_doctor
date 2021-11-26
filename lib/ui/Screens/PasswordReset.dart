import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:alo_doctor_doctor/api/login.dart';
import 'package:alo_doctor_doctor/utils/Colors.dart';
import 'package:alo_doctor_doctor/utils/styles.dart';

import 'package:alo_doctor_doctor/utils/MyConstants.dart';
import 'package:alo_doctor_doctor/utils/form_validator.dart';
import 'package:alo_doctor_doctor/providers/profileProvider.dart';

class PasswordReset extends StatefulWidget {
  bool isfromProfile;
  int userId;
  String userEmail;
  PasswordReset(this.isfromProfile, this.userId, this.userEmail);

  @override
  _PasswordResetState createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  TextEditingController emailController;
  final otpController = TextEditingController();
  final _passwordController = TextEditingController();

  String email;
  int otp;
  int sentOtp;
  int userId;
  int password;
  int cpassword;
  bool otpSent = false;
  bool verified = false;
  final GlobalKey<FormState> _emailKey = GlobalKey();
  final GlobalKey<FormState> _otpKey = GlobalKey();
  final GlobalKey<FormState> _passKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    if (widget.isfromProfile) {
      userId = widget.userId;
      otpSent = true;
      email = widget.userEmail;
    }
  }

  void forgotPassword(String email) async {
    try {
      if (_emailKey.currentState.validate()) {
        _emailKey.currentState.save();
        var response = await LoginCheck().forgetPassword(email);

        Fluttertoast.showToast(
          msg: "Verification mail sent",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
        setState(() {
          sentOtp = response["otp"];
          userId = response["user_id"];
          print(sentOtp);
          otpSent = true;
        });
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: e,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  void resendOtp(String email) async {
    try {
      var response = await LoginCheck().forgetPassword(email);
      print(otpController);
      Fluttertoast.showToast(
        msg: "Verification mail sent",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      setState(() {
        otpSent = true;
      });
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  void verifyOtp() async {
    try {
      if (_otpKey.currentState.validate()) {
        _otpKey.currentState.save();
        print(otp.toString());
        await LoginCheck().verifyOtp(otp, userId);

        Fluttertoast.showToast(
          msg: "Verification successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
        setState(() {
          print("verification successful");
          verified = true;
        });
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: e,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  void changePassword() async {
    try {
      if (_passKey.currentState.validate()) {
        _passKey.currentState.save();
        print(password);
        print(cpassword);
        var response =
            await LoginCheck().changePassword(userId, password, cpassword);

        Fluttertoast.showToast(
          msg: "Password Changed Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
        if (widget.isfromProfile)
          Provider.of<ProfileProvider>(context, listen: false).logOut(context);
        else
          Navigator.of(context).pushReplacementNamed(signIn);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: e,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
        child: ListView(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Column(children: [
                Hero(
                  tag: "Logo",
                  child: Image(
                    image: AssetImage('assets/images/alo_logo.png'),
                    height: 100,
                    width: 100,
                  ),
                ),
                Text(
                  verified ? "Change Password" : "Reset Password",
                  style: TextStyle(fontSize: 22),
                  textAlign: TextAlign.center,
                )
              ]),
            ),
            SizedBox(
              height: 35,
            ),
            !verified
                ? Container(
                    // margin: EdgeInsets.only(top: 50),
                    height: MediaQuery.of(context).size.height * 0.5,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    color: Colors.grey.shade200,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              otpSent
                                  ? 'Enter OTP'
                                  : 'Enter your Registered email address.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          otpSent
                              ? Form(
                                  key: _otpKey,
                                  child: Column(
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              64, 40, 64, 0),
                                          child: TextFormField(
                                            controller: otpController,
                                            keyboardType: TextInputType.number,
                                            textInputAction:
                                                TextInputAction.done,
                                            onChanged: (value) {
                                              otp = int.parse(value);
                                            },
                                            onFieldSubmitted: (value) {
                                              verifyOtp();
                                            },
                                            validator: (text) {
                                              if (text == null ||
                                                  text.isEmpty) {
                                                return 'Please enter OTP';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                                hintText: 'OTP',
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 16.0,
                                                        vertical: 16.0)),
                                            style: Styles.buttonTextBlack,
                                            textAlign: TextAlign.center,
                                          )),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      ElevatedButton(
                                        onPressed: verifyOtp,
                                        child: Text("Verify"),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    accentBlueLight),
                                            foregroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.black)),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            print(email);
                                            resendOtp(email);
                                          },
                                          child: Text("Resend OTP"))
                                    ],
                                  ),
                                )
                              : Form(
                                  key: _emailKey,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            64, 40, 64, 0),
                                        child: TextFormField(
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          textInputAction: TextInputAction.done,
                                          validator: (value) =>
                                              FormValidator.validateEmail(
                                                  value),
                                          controller: emailController,
                                          onChanged: (value) {
                                            email = value;
                                          },
                                          onFieldSubmitted: (value) {
                                            email = value;
                                            forgotPassword(value);
                                          },
                                          decoration: InputDecoration(
                                              hintText: 'E-mail',
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 16.0,
                                                      vertical: 16.0)),
                                          style: Styles.buttonTextBlack,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          print(email);
                                          forgotPassword(email);
                                        },
                                        child: Text("Send OTP"),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    accentBlueLight),
                                            foregroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.black)),
                                      ),
                                    ],
                                  ),
                                ),
                        ]),
                  )
                : Container(
                    // margin: EdgeInsets.only(top: 50),
                    height: MediaQuery.of(context).size.height * 0.5,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    color: Colors.grey.shade200,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Form(
                            key: _passKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration:
                                      InputDecoration(labelText: 'Password'),
                                  obscureText: true,
                                  textInputAction: TextInputAction.next,
                                  controller: _passwordController,
                                  validator: (value) =>
                                      FormValidator.validatePassword(value),
                                  onFieldSubmitted: (value) {
                                    password = int.parse(value);
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Confirm Password'),
                                    obscureText: true,
                                    textInputAction: TextInputAction.done,
                                    onChanged: (value) {
                                      cpassword = int.parse(value);
                                    },
                                    onFieldSubmitted: (_) => changePassword,
                                    validator: (value) {
                                      if (value != _passwordController.text) {
                                        return 'Password do not Match';
                                      }
                                      return null;
                                    }),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: changePassword,
                            child: Text('Change'),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(accentBlueLight),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.black)),
                          ),
                        ]),
                  ),
          ],
        ),
      ),
    );
  }
}
