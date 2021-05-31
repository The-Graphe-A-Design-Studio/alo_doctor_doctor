import 'package:alo_doctor_doctor/api/login.dart';
import 'package:alo_doctor_doctor/utils/Colors.dart';
import 'package:alo_doctor_doctor/utils/MyConstants.dart';
import 'package:alo_doctor_doctor/widgets/customButton.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey();

    Map<String, String> _authData = {
      'email': '',
      'password': '',
    };
    void Login() async {
      bool login = await LoginCheck()
          .UserLogin(_authData['email'], _authData['password']);
      if (login == 1) {
        print('logged');
      }
      // ignore: unawaited_futures
    }

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
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Invalid email';
                      }
                      return null;
                    },
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
                    validator: (value) {
                      if (value.isEmpty || value.length < 5) {
                        return 'Password is too short';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _authData['password'] = value;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    btnText: 'Login',
                    backgroundColor: accentBlueLight,
                    btnWidth: 100,
                    onPressed: () {
                      Login();
                      // Navigator.pushNamed(context, signUpPage);
                    },
                  ),
                  CustomButton(
                    btnText: 'SignUp',
                    backgroundColor: accentBlueLight,
                    btnWidth: 100,
                    onPressed: () {
                      Navigator.pushNamed(context, registerPage);
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
