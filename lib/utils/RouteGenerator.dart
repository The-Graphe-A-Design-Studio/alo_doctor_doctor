import 'package:alo_doctor_doctor/ui/HomePage.dart';
import 'package:alo_doctor_doctor/ui/LoginPage.dart';
import 'package:alo_doctor_doctor/ui/RegisterPage.dart';
import 'package:alo_doctor_doctor/ui/Screens/AddPhoto.dart';
import 'package:alo_doctor_doctor/ui/Screens/AddSlots.dart';
import 'package:alo_doctor_doctor/ui/Screens/Appointments.dart';
import 'package:alo_doctor_doctor/ui/Screens/Consultation.dart';
import 'package:alo_doctor_doctor/ui/Screens/ConsultationFee.dart';
import 'package:alo_doctor_doctor/ui/Screens/ConsultationSchedule.dart';
import 'package:alo_doctor_doctor/ui/Screens/PaymentScreen.dart';
import 'package:alo_doctor_doctor/ui/Screens/ProfileDetails.dart';
import 'package:alo_doctor_doctor/ui/Screens/RecordScreen.dart';
import 'package:alo_doctor_doctor/ui/Screens/ReminderScreen.dart';
import 'package:alo_doctor_doctor/ui/Screens/SignIn.dart';
import 'package:alo_doctor_doctor/ui/Screens/SignUp.dart';
import 'package:alo_doctor_doctor/ui/Screens/VideoCallingScreen.dart';
import 'package:alo_doctor_doctor/ui/Screens/ViewReport.dart';
import 'package:alo_doctor_doctor/ui/Screens/calendarScreen.dart';
import 'package:alo_doctor_doctor/ui/SplashScreen.dart';
import 'package:alo_doctor_doctor/widgets/photoViewer.dart';
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
      // case appointmentDetails:
      //   return FadeRoute(
      //     page: AppointmentDetails(),
      //   );
      case consultPage:
        return FadeRoute(
          page: Consultation(),
        );
      case consultSched:
        return FadeRoute(
          page: ConsultationSchedule(),
        );
      case consultFee:
        return FadeRoute(
          page: ConsultationFee(),
        );
      case calendarScreen:
        return FadeRoute(
          page: CalendarScreen(),
        );
      case reminderScreen:
        return FadeRoute(
          page: ReminderScreen(),
        );
      case recordScreen:
        return FadeRoute(
          page: RecordScreen(),
        );
      case profileDetails:
        return FadeRoute(
          page: ProfileDetails(),
        );
      case addPhoto:
        return FadeRoute(
          page: AddPhoto(),
        );
      case paymentScreen:
        return FadeRoute(
          page: PaymentScreen(),
        );
      case signIn:
        return FadeRoute(
          page: SignInPage(),
        );
      case signUp:
        return FadeRoute(
          page: SignUpPage(),
        );

      case viewReport:
        ViewReport argument = args as ViewReport;

        return FadeRoute(
          page: ViewReport(
            reportList: argument.reportList,
            rDescription: argument.rDescription,
          ),
        );

      case photoViewer:
        PhotoViewer argument = args as PhotoViewer;

        return FadeRoute(
          page: PhotoViewer(
            argument.imgPath,
          ),
        );

        // return MaterialPageRoute(builder: (BuildContext context) {
        //   PhotoViewer argument = args as PhotoViewer;
        //   return PhotoViewer(
        //     argument.imgPath,
        //   );
        // });

      // case videoCallingScreen:
      //   return FadeRoute(
      //     page: VideoCallingScreen(),
      //   );
      case addSlotes:
        return FadeRoute(
          page: AddSlots(),
        );
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
