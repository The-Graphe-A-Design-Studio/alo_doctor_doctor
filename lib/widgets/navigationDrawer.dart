import 'package:alo_doctor_doctor/api/login.dart';
import 'package:alo_doctor_doctor/models/doctor.dart';
import 'package:alo_doctor_doctor/providers/profileProvider.dart';
import 'package:alo_doctor_doctor/utils/MyConstants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/styles.dart';

class NavigationDrawer extends StatelessWidget {
  Doctor doctor;
  void initState() async {
    doctor = await LoginCheck().UserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Consumer<ProfileProvider>(
              builder: (ctx, data, child) {
                print(
                    'consumer runs in navigator--- ${data.currentUser.profilePicPath}');
                return ListTile(
                  leading: data.currentUser.profilePicPath == null
                      ? Image(
                          image: AssetImage(
                            'assets/images/user.png',
                          ),
                          height: 50.0,
                          width: 50.0,
                        )
                      : Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://developers.thegraphe.com/alodoctor/public${data.currentUser.profilePicPath}'),
                              )),
                        ),
                  title: Text(
                    "${data.currentUser.name}",
                    style: Styles.boldHeading,
                  ),
                  subtitle: Text('View and edit profile'),
                  trailing: child,
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.pushNamed(context, profileDetails);
                  },
                );
              },
              child: RotatedBox(
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
                  'assets/images/myDoctor.png',
                ),
                height: 30.0,
                width: 50.0,
              ),
              title: Text(
                "Slots",
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
                "Documents",
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
            // ListTile(
            //   leading: Image(
            //     image: AssetImage(
            //       'assets/images/bell.png',
            //     ),
            //     height: 30.0,
            //     width: 50.0,
            //   ),
            //   title: Text(
            //     "Reminders",
            //     style: Styles.buttonTextBlack,
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
            // ListTile(
            //   leading: Image(
            //     image: AssetImage(
            //       'assets/images/payment.png',
            //     ),
            //     height: 30.0,
            //     width: 50.0,
            //   ),
            //   title: Text(
            //     "Payments",
            //     style: Styles.buttonTextBlack,
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
            // ListTile(
            //   leading: Image(
            //     image: AssetImage(
            //       'assets/images/settings.png',
            //     ),
            //     height: 28.0,
            //     width: 50.0,
            //   ),
            //   title: Text(
            //     "Settings",
            //     style: Styles.buttonTextBlack,
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
            GestureDetector(
              onTap: () async {
                Provider.of<ProfileProvider>(context, listen: false)
                    .logOut(context);
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('token');
                prefs.clear();
                Navigator.pushNamed(context, signIn);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: ListTile(
                  leading: Icon(Icons.power_settings_new, size: 32),
                  title: Text(
                    "Logout",
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
