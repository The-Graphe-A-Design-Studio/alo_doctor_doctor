import 'package:alo_doctor_doctor/utils/Colors.dart';
import 'package:alo_doctor_doctor/utils/MyConstants.dart';
import 'package:alo_doctor_doctor/utils/styles.dart';
import 'package:alo_doctor_doctor/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum WidgetMarker {
  mobileScreen,
  otpVerification,
}

class _LoginPageState extends State<LoginPage> {
  WidgetMarker selectedWidgetMarker;

  final GlobalKey<FormState> _formKeyOtp = GlobalKey<FormState>();

  // final GlobalKey<FormState> _formKeySignIn = GlobalKey<FormState>();

  final otpController = TextEditingController();
  final mobileNumberControllerSignIn = TextEditingController();
  String userToken;
  bool rememberMe = true;

  String _otpCode = "";

  @override
  void initState() {
    super.initState();
    selectedWidgetMarker = WidgetMarker.mobileScreen;
  }

  @override
  void dispose() {
    otpController.dispose();
    mobileNumberControllerSignIn.dispose();
    super.dispose();
  }

  void clearControllers() {
    otpController.clear();
    mobileNumberControllerSignIn.clear();
  }

  void saveOTP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('otp', _otpCode);
  }

  Widget getMobileNumberWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.only(top: 100),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Hero(
                  tag: "Logo",
                  child: Image(
                    image: AssetImage('assets/images/alo-logo.jpg'),
                    height: 200.0,
                    width: 200.0,
                  ),
                ),
                Text(
                  'Please enter your Phone number',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 22.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(64, 50, 64, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: accentBlueLight,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 0.1,
                          blurRadius: 10, // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextField(
                      onSubmitted: (value) {},
                      decoration: InputDecoration(
                          hintText: 'Enter Mobile Number',
                          border: InputBorder.none,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Image(
                              image: AssetImage(
                                'assets/images/user.png',
                              ),
                              height: 18.0,
                              width: 18.0,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 16.0)),
                      style: Styles.buttonTextBlack,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(64, 30, 64, 0),
                    child: CustomButton(
                      btnText: 'GENERATE OTP',
                      onPressed: () {
                        print('Button Pressed');
                        setState(() {
                          selectedWidgetMarker = WidgetMarker.otpVerification;
                        });
                      },
                    ))
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 100,
          child: Container(
            height: 30,
            width: double.infinity,
            decoration: BoxDecoration(color: accentBlueLight),
          ),
        ),
      ],
    );
  }

  Widget getOtpVerificationWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.only(top: 60),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Row(
                    children: [
                      InkWell(
                        child: Image(
                          image: AssetImage(
                            'assets/images/arrow.png',
                          ),
                          height: 22.0,
                          width: 22.0,
                        ),
                        onTap: () {
                          setState(() {
                            selectedWidgetMarker = WidgetMarker.mobileScreen;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Enter Code',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 24.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 20, 32, 0),
                  child: Text(
                    'We have sent you an sms on +919999955555 with a 6 digit verification code',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(64, 30, 64, 0),
                  child: TextFieldPin(
                    borderStyeAfterTextChange: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(color: Colors.black87),
                    ),
                    borderStyle: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(color: Colors.black87),
                    ),
                    codeLength: 6,
                    boxSize: 30,
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                    filledAfterTextChange: true,
                    filledColor: Colors.white,
                    onOtpCallback: (code, isAutofill) {
                      print(code);
                      this._otpCode = code;
                    },
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Did not receive your code?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 16.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(64, 60, 64, 0),
                  child: CustomButton(
                    btnText: 'VALIDATE OTP',
                    onPressed: () {
                      print('Button Pressed');
                      Navigator.pushReplacementNamed(context, registerPage);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 100,
          child: Column(
            children: [
              Hero(
                tag: "Logo",
                child: Image(
                  image: AssetImage('assets/images/alo-logo.jpg'),
                  height: 80.0,
                  width: 80.0,
                ),
              ),
              Container(
                height: 30,
                width: double.infinity,
                decoration: BoxDecoration(color: accentBlueLight),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getCustomWidget() {
    switch (selectedWidgetMarker) {
      case WidgetMarker.otpVerification:
        return getOtpVerificationWidget();
      case WidgetMarker.mobileScreen:
        return getMobileNumberWidget();
    }
    return getMobileNumberWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: getCustomWidget());
  }
}
