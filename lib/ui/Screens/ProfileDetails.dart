import 'package:alo_doctor_doctor/utils/Colors.dart';
import 'package:alo_doctor_doctor/utils/MyConstants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/doctor.dart';
import '../../providers/profileProvider.dart';

class ProfileDetails extends StatefulWidget {
  @override
  _ProfileDetailsState createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  Details userDetails;

  @override
  Widget build(BuildContext context) {
    final profileData = Provider.of<ProfileProvider>(context);
    userDetails = profileData.currentUser;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: Column(
            children: [
              Text(
                userDetails.name ?? 'Doctor',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          backgroundColor: accentBlueLight,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 30, horizontal: 30.0),
                  child: Container(
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff62798C)),
                            ),
                            Text(
                              userDetails.name ?? 'Add your name',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            )
                          ],
                        ),
                        Expanded(child: Container()),
                        userDetails.profilePicPath == null
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    addPhoto,
                                  );
                                },
                                child: Container(
                                  width: 67,
                                  height: 67,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Add'),
                                        Text('photo'),
                                      ],
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 0),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(200),
                                      ),
                                      color: Color(0xffC4C4C4)),
                                ))
                            : Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    width: 70,
                                    height: 70,
                                    child: Container(),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                'https://developers.thegraphe.com/alodoctor/public${userDetails.profilePicPath}')),
                                        border: Border.all(width: 0),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(200),
                                        ),
                                        color: Color(0xffC4C4C4)),
                                  ),
                                  Positioned(
                                      bottom: -10.5,
                                      right: -10.5,
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 0),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(200),
                                          ),
                                          color: accentBlueLight,
                                        ),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.camera_alt_outlined,
                                            size: 25,
                                          ),
                                          onPressed: () {
                                            Navigator.pushNamed(
                                              context,
                                              addPhoto,
                                            );
                                          },
                                        ),
                                      ))
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
                ProfileField(
                  label: 'Contact No',
                  value: userDetails.phone == null
                      ? ""
                      : userDetails.phone.toString(),
                ),
                ProfileField(
                  label: 'Email id',
                  value: userDetails.email ?? "",
                ),
                ProfileField(
                  label: 'Gender',
                  value: userDetails.gender ?? "",
                ),
                ProfileField(
                  label: 'Date of Birth',
                  value:
                      "${DateFormat("yyyy-MM-dd").format(userDetails.dob)}" ??
                          "",
                ),
                ProfileField(
                  label: 'Category',
                  value: 'Physiotherapy',
                ),
                ProfileField(
                  label: 'Documents',
                  icon: Icons.picture_as_pdf_outlined,
                ),
                ProfileField(
                  label: 'Sub category',
                  icon: Icons.arrow_forward_ios,
                ),
                ProfileField(
                  label: 'Clinic Location',
                  icon: Icons.arrow_forward_ios,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: new FloatingActionButton(
            elevation: 0.0,
            child: new Icon(Icons.edit),
            backgroundColor: accentBlue,
            onPressed: () {
              Navigator.pushNamed(context, registerPage);
            }));
  }
}

class ProfileField extends StatelessWidget {
  IconData icon;
  String label;
  String value;
  Function ontap;
  ProfileField({
    @required this.label,
    this.value,
    this.icon,
    this.ontap,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap ?? () {},
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 7.0),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 27.0),
                child: Row(
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                          fontSize: 15,
                          color: Color(0xff62798C),
                          fontWeight: FontWeight.w600),
                    ),
                    Expanded(child: Container()),
                    icon == null
                        ? Text(
                            value ?? "",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          )
                        : Icon(icon),
                  ],
                ),
              ),
              SizedBox(
                height: 19,
              ),
              Container(
                height: 1,
                width: double.infinity,
                color: Color(0xffCCCCCC),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
