import 'package:alo_doctor_doctor/ui/SplashScreen.dart';
import 'package:alo_doctor_doctor/utils/RouteGenerator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/profileProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => ProfileProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Alo Doctor - Doctor',
        theme: ThemeData(
          fontFamily: 'OpenSans',
          primaryColor: Color(0xff252427),
          canvasColor: Colors.transparent,
          accentColor: Colors.black12,
          accentColorBrightness: Brightness.dark,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
        home: SplashScreen(),
      ),
    );
  }
}
