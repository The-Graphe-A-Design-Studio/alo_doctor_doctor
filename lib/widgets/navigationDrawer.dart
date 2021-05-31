import 'package:alo_doctor_doctor/utils/MyConstants.dart';
import 'package:flutter/material.dart';

import '../utils/styles.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, profileDetails);
              },
              child: ListTile(
                leading: Image(
                  image: AssetImage(
                    'assets/images/user.png',
                  ),
                  height: 50.0,
                  width: 50.0,
                ),
                title: Text(
                  "Dr.Ramya",
                  style: Styles.boldHeading,
                ),
                subtitle: Text('View and edit profile'),
                trailing: RotatedBox(
                  quarterTurns: 2,
                  child: Image(
                    image: AssetImage(
                      'assets/images/planeArrow.png',
                    ),
                    height: 14.0,
                    width: 14.0,
                  ),
                ),
              ),
            ),
            Divider(color: Colors.black87),
            // ListTile(
            //   leading: Image(
            //     image: AssetImage(
            //       'assets/images/alo_logo.png',
            //     ),
            //     height: 50.0,
            //     width: 50.0,
            //   ),
            //   title: Text(
            //     "Health Plan for your family",
            //     style: Styles.regularHeading,
            //   ),
            //   trailing: RotatedBox(
            //     quarterTurns: 2,
            //     child: Image(
            //       image: AssetImage(
            //         'assets/images/planeArrow.png',
            //       ),
            //       height: 14.0,
            //       width: 14.0,
            //     ),
            //   ),
            // ),
            // Divider(color: Colors.black87),
            ListTile(
              leading: Image(
                image: AssetImage(
                  'assets/images/appointment.png',
                ),
                height: 30.0,
                width: 50.0,
              ),
              title: Text(
                "Appoinments",
                style: Styles.buttonTextBlack,
              ),
              trailing: RotatedBox(
                quarterTurns: 2,
                child: Image(
                  image: AssetImage(
                    'assets/images/planeArrow.png',
                  ),
                  height: 14.0,
                  width: 14.0,
                ),
              ),
            ),
            ListTile(
              leading: Image(
                image: AssetImage(
                  'assets/images/consultations.png',
                ),
                height: 35.0,
                width: 50.0,
              ),
              title: Text(
                "Consultations",
                style: Styles.buttonTextBlack,
              ),
              trailing: RotatedBox(
                quarterTurns: 2,
                child: Image(
                  image: AssetImage(
                    'assets/images/planeArrow.png',
                  ),
                  height: 14.0,
                  width: 14.0,
                ),
              ),
            ),
            ListTile(
              leading: Image(
                image: AssetImage(
                  'assets/images/medicalRecords.png',
                ),
                height: 30.0,
                width: 50.0,
              ),
              title: Text(
                "Medical Records",
                style: Styles.buttonTextBlack,
              ),
              trailing: RotatedBox(
                quarterTurns: 2,
                child: Image(
                  image: AssetImage(
                    'assets/images/planeArrow.png',
                  ),
                  height: 14.0,
                  width: 14.0,
                ),
              ),
            ),
            ListTile(
              leading: Image(
                image: AssetImage(
                  'assets/images/myDoctor.png',
                ),
                height: 30.0,
                width: 50.0,
              ),
              title: Text(
                "My Doctors",
                style: Styles.buttonTextBlack,
              ),
              trailing: RotatedBox(
                quarterTurns: 2,
                child: Image(
                  image: AssetImage(
                    'assets/images/planeArrow.png',
                  ),
                  height: 14.0,
                  width: 14.0,
                ),
              ),
            ),
            ListTile(
              leading: Image(
                image: AssetImage(
                  'assets/images/bell.png',
                ),
                height: 30.0,
                width: 50.0,
              ),
              title: Text(
                "Reminders",
                style: Styles.buttonTextBlack,
              ),
              trailing: RotatedBox(
                quarterTurns: 2,
                child: Image(
                  image: AssetImage(
                    'assets/images/planeArrow.png',
                  ),
                  height: 14.0,
                  width: 14.0,
                ),
              ),
            ),
            ListTile(
              leading: Image(
                image: AssetImage(
                  'assets/images/payment.png',
                ),
                height: 30.0,
                width: 50.0,
              ),
              title: Text(
                "Payments",
                style: Styles.buttonTextBlack,
              ),
              trailing: RotatedBox(
                quarterTurns: 2,
                child: Image(
                  image: AssetImage(
                    'assets/images/planeArrow.png',
                  ),
                  height: 14.0,
                  width: 14.0,
                ),
              ),
            ),
            Divider(color: Colors.black87),
            ListTile(
              leading: Image(
                image: AssetImage(
                  'assets/images/info.png',
                ),
                height: 28.0,
                width: 50.0,
              ),
              title: Text(
                "Read about health",
                style: Styles.buttonTextBlack,
              ),
              trailing: RotatedBox(
                quarterTurns: 2,
                child: Image(
                  image: AssetImage(
                    'assets/images/planeArrow.png',
                  ),
                  height: 14.0,
                  width: 14.0,
                ),
              ),
            ),
            ListTile(
              leading: Image(
                image: AssetImage(
                  'assets/images/question.png',
                ),
                height: 28.0,
                width: 50.0,
              ),
              title: Text(
                "Help Center",
                style: Styles.buttonTextBlack,
              ),
              trailing: RotatedBox(
                quarterTurns: 2,
                child: Image(
                  image: AssetImage(
                    'assets/images/planeArrow.png',
                  ),
                  height: 14.0,
                  width: 14.0,
                ),
              ),
            ),
            ListTile(
              leading: Image(
                image: AssetImage(
                  'assets/images/settings.png',
                ),
                height: 28.0,
                width: 50.0,
              ),
              title: Text(
                "Settings",
                style: Styles.buttonTextBlack,
              ),
              trailing: RotatedBox(
                quarterTurns: 2,
                child: Image(
                  image: AssetImage(
                    'assets/images/planeArrow.png',
                  ),
                  height: 14.0,
                  width: 14.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
