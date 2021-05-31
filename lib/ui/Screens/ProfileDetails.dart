import 'package:alo_doctor_doctor/utils/Colors.dart';
import 'package:alo_doctor_doctor/utils/MyConstants.dart';
import 'package:flutter/material.dart';

class ProfileDetails extends StatefulWidget {
  @override
  _ProfileDetailsState createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  @override
  Widget build(BuildContext context) {
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
              'Dr.Ramya G S',
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
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 30.0),
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
                            'Dr.Ramya G S',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          )
                        ],
                      ),
                      Expanded(child: Container()),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, addPhoto);
                        },
                        child: Container(
                          width: 67,
                          height: 67,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                        ),
                      )
                    ],
                  ),
                ),
              ),
              ProfileField(
                label: 'Contact No',
                value: '77777 55555',
              ),
              ProfileField(
                label: 'Email id',
                value: 'msg@gmail.com',
              ),
              ProfileField(
                label: 'Gender',
                value: 'Male',
              ),
              ProfileField(
                label: 'Date of Birth',
                value: '30/10/1990',
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
    );
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
