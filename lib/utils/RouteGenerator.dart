import 'package:alo_doctor_doctor/ui/HomePage.dart';
import 'package:alo_doctor_doctor/ui/LoginPage.dart';
import 'package:alo_doctor_doctor/ui/RegisterPage.dart';
import 'package:alo_doctor_doctor/ui/Screens/PasswordReset.dart';
import 'package:alo_doctor_doctor/ui/Screens/AddPhoto.dart';
import 'package:alo_doctor_doctor/ui/Screens/AddCoverPhoto.dart';
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
import 'package:alo_doctor_doctor/ui/Screens/UploadPrescription.dart';
import 'package:alo_doctor_doctor/ui/Screens/Video/NetworkVideoPlayer.dart';
import 'package:alo_doctor_doctor/ui/Screens/Video/FileVideoPlayer.dart';
import 'package:alo_doctor_doctor/ui/Screens/ViewReport.dart';
import 'package:alo_doctor_doctor/ui/Screens/WebView.dart';
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
        return MaterialPageRoute(builder: (BuildContext context) {
          RegisterPage argument = args as RegisterPage;
          return RegisterPage(
            argument.isEdit,
          );
        });

      case passwordReset:
        PasswordReset argument = args as PasswordReset;
        return FadeRoute(
          page: PasswordReset(
              argument.isfromProfile, argument.userId, argument.userEmail),
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
      case addCoverPhoto:
        return FadeRoute(
          page: AddCoverPhoto(),
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
          page: PhotoViewer(argument.imgPath, argument.isNetwork),
        );

      case webView:
        WebViewLoad argument = args as WebViewLoad;
        return FadeRoute(
          page: WebViewLoad(argument.title, argument.webLink),
        );

      case networkVideo:
        NetworkPlayerWidget argument = args as NetworkPlayerWidget;
        return FadeRoute(
          page: NetworkPlayerWidget(argument.networkVideo),
        );

      case filevideo:
        FilePlayerWidget argument = args as FilePlayerWidget;
        return FadeRoute(
          page: FilePlayerWidget(argument.videoFile),
        );

      case prescription:
        UploadPrescription argument = args as UploadPrescription;
        return FadeRoute(
          page: UploadPrescription(argument.id),
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
