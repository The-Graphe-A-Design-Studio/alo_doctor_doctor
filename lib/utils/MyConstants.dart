import 'package:flutter/material.dart';
import 'package:alo_doctor_doctor/utils/Colors.dart';

//API Key

//Basic Pages
const String splashPage = "/";

//Login or SignUp Pages
const String loginPage = "/loginPage";

//Pages which don't need LoggedIn User

//Pages once the user is LoggedIn
const String homePage = "/homePage";
const String registerPage = "/registerPage";

const String consultPage = '/consultPage';
const String consultSched = '/consultSchedule';
const String consultFee = '/consultFee';
const String topDoctorPage = '/topDoctor';
const String doctorDetailsPage = '/docDetails';
const String appointmentScreen = '/appoinment';
const String rescheduleAppointmetScreen = './reschedule';
const String paymentScreen = './payment';
const String paymentFeedback = './payfeedback';
const String myAppointment = './myAppontment';
const String calendarScreen = '/calendarScreen';
const String reminderScreen = '/reminderScreen';
const String recordScreen = '/recordScreen';
const String appointmentDetails = './appointmentDetails';
const String profileDetails = './profileDetails';
const String addPhoto = './addPhoto';
const String addCoverPhoto = './addCoverPhoto';
const String signIn = './signIn';
const String signUp = './signUp';
// const String videoCallingScreen = './videoCalling';
const String addSlotes = './addslotes';
const String viewReport = './viewReport';
const String photoViewer = './photoViewer';
const String webView = './webView';
const String networkVideo = './networkVideo';
const String filevideo = './filevideo';
const String prescription = './prescription';
const String passwordReset = "./passwordReset";
// buttons
Widget backButton(BuildContext context) => ElevatedButton(
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(accentBlueLight)),
      child: Image(
        image: AssetImage('./assets/images/arrow.png'),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

// base url
const baseUrl = "https://www.alodoctor-care.com/app-backend/public";
