import 'package:alo_doctor_doctor/ui/HomePage.dart';
import 'package:alo_doctor_doctor/ui/LoginPage.dart';
import 'package:alo_doctor_doctor/ui/RegisterPage.dart';
import 'package:alo_doctor_doctor/ui/Screens/AppointmentDetailScreen.dart';
import 'package:alo_doctor_doctor/ui/Screens/Appointments.dart';
import 'package:alo_doctor_doctor/ui/SplashScreen.dart';
import 'package:flutter/material.dart';

import 'FadeTransition.dart';
import 'MyConstants.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      //Basic Pages
      case splashPage:
        return FadeRoute(page: SplashScreen());

      case loginPage:
        return FadeRoute(page: LoginPage());

      //Pages once the user is LoggedIn - Transporter
      case homePage:
        return FadeRoute(
          page: HomePage(),
        );

      case registerPage:
        return FadeRoute(
          page: RegisterPage(),
        );

      case appointmentScreen:
        return FadeRoute(
          page: Appointments(),
        );
      case appointmentDetails:
        return FadeRoute(page: AppointmentDetails());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        body: Center(
          child: Text('ERROR ROUTE'),
        ),
      );
    });
  }
}
