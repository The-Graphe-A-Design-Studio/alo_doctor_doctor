import 'package:alo_doctor_doctor/utils/Colors.dart';
import 'package:alo_doctor_doctor/utils/MyConstants.dart';
import 'package:alo_doctor_doctor/utils/styles.dart';
import 'package:alo_doctor_doctor/widgets/customDropDown.dart';
import 'package:alo_doctor_doctor/widgets/documentUpload.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/date_picker_theme.dart';
import 'package:flutter_holo_date_picker/widget/date_picker_widget.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int selectedWidget;
  String selectedGender = '';
  String selectedBloodGroup = '';
  String selectedIsMarried = '';
  DateTime _selectedBirthday;
  List<Modal> uploadList = [];
  List<Modal> locationchoice = [];
  int locChoice;
  String _chosenValue = "Physiotherapy";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedWidget = 0;
    uploadList.add(Modal(name: 'Adhar card.jpg', isSelected: false));
    uploadList.add(Modal(name: 'Doctor\'s degree.jpg', isSelected: false));
    uploadList.add(Modal(name: 'Certificates', isSelected: false));
    uploadList.add(Modal(name: 'Certificates', isSelected: false));
    locationchoice.add(Modal(name: 'Use my Location', isSelected: false));
    locationchoice.add(Modal(name: 'Pick a city', isSelected: false));
  }

  Widget getUserNameWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'What is your name?',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 22.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(64, 40, 64, 0),
          child: TextField(
            onSubmitted: (value) {},
            decoration: InputDecoration(
                hintText: 'Name',
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0)),
            style: Styles.buttonTextBlack,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget getEmailIdWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'What is your email id?',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 22.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(64, 40, 64, 0),
          child: TextField(
            onSubmitted: (value) {},
            decoration: InputDecoration(
                hintText: 'Email',
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0)),
            style: Styles.buttonTextBlack,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget getGenderWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'Which gender do you identify with?',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 22.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: InkWell(
            onTap: () {
              setState(() {
                selectedGender = 'male';
              });
            },
            child: Container(
                width: 120,
                height: 40,
                padding: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: accentBlueLight,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 0.1,
                      blurRadius: 10, // changes position of shadow
                    ),
                  ],
                  color: selectedGender == 'male'
                      ? const Color(0xFFECF89C)
                      : Colors.white,
                ),
                child: Center(
                  child: Text(
                    'MALE',
                    textAlign: TextAlign.center,
                  ),
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: InkWell(
            onTap: () {
              setState(() {
                selectedGender = 'female';
              });
            },
            child: Container(
                width: 120,
                height: 40,
                padding: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: accentBlueLight,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 0.1,
                      blurRadius: 10, // changes position of shadow
                    ),
                  ],
                  color: selectedGender == 'female'
                      ? const Color(0xFFECF89C)
                      : Colors.white,
                ),
                child: Center(
                  child: Text(
                    'FEMALE',
                    textAlign: TextAlign.center,
                  ),
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: InkWell(
            onTap: () {
              setState(() {
                selectedGender = 'other';
              });
            },
            child: Container(
                width: 120,
                height: 40,
                padding: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: accentBlueLight,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 0.1,
                      blurRadius: 10, // changes position of shadow
                    ),
                  ],
                  color: selectedGender == 'other'
                      ? const Color(0xFFECF89C)
                      : Colors.white,
                ),
                child: Center(
                  child: Text(
                    'OTHER',
                    textAlign: TextAlign.center,
                  ),
                )),
          ),
        ),
      ],
    );
  }

  Widget getCategoryWidget() {
    _onChangeModelDropdown(String choosen) {
      setState(() {
        _chosenValue = choosen;
        print(_chosenValue);
      });
    }

    List items = <String>[
      'Physiotherapy',
      'Cardiology',
      'Gynacology',
    ].map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'Select which category Doctor are you?',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 22.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40, left: 40, right: 40),
          child: CustomDropdown(
            dropdownMenuItemList: items,
            onChanged: _onChangeModelDropdown,
            value: _chosenValue,
            isEnabled: true,
          ),
        ),
      ],
    );
  }

  Widget getSubCategoryWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        direction: Axis.horizontal,
        children: [
          Wrap(
            children: <Widget>[
              SubCategory(text: 'Physiotherapy'),
              SubCategory(text: 'Physiotherapy'),
              SubCategory(text: 'Radio'),
              SubCategory(text: 'Physiotherapy'),
              SubCategory(text: 'Physiotherapy'),
              SubCategory(text: 'Physiotherapy'),
            ],
          ),
        ],
      ),
    );
  }

  Widget getBirthdayWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'When is your birthday?',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 22.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(64, 40, 64, 0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: accentBlueLight,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 0.1,
                  blurRadius: 10, // changes position of shadow
                ),
              ],
              color: selectedGender == 'male'
                  ? const Color(0xFFECF89C)
                  : Colors.white,
            ),
            child: DatePickerWidget(
              looping: false,
              // default is not looping
              firstDate: DateTime(1990, 01, 01),
              lastDate: DateTime(2030, 1, 1),
              initialDate: DateTime(1991, 10, 12),
              dateFormat: "dd-MMM-yyyy",
              locale: DatePicker.localeFromString('en'),
              onChange: (DateTime newDate, _) => _selectedBirthday = newDate,
              pickerTheme: DateTimePickerTheme(
                itemTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 19,
                ),
                dividerColor: Colors.black87,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget getDocumentsWidget(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'Upload Your documents.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 22.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 10, 40, 0),
          child: Image(
            image: AssetImage('assets/images/upload.png'),
            height: 57,
            width: 57,
          ),
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
            child: Container(
              height: 250,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: uploadList.length,
                  itemBuilder: (context, index) {
                    return documentUpload(
                        label: uploadList[index].name,
                        isSelected: uploadList[index].isSelected,
                        onTap: () {
                          setState(() {
                            uploadList.forEach((element) {
                              element.isSelected = false;
                            });

                            uploadList[index].isSelected = true;
                          });
                          uploadList.forEach((element) {
                            print(element.isSelected);
                          });
                        });
                  }),
            )),
        FloatingActionButton(
          onPressed: null,
          elevation: 1.0,
          child: new Icon(
            Icons.add,
            color: Colors.black,
          ),
          backgroundColor: new Color(0xFFDFF4F3),
        )
      ],
    );
  }

  Widget getLocationWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'Which city are you from?',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 22.0,
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
            child: Container(
              height: 350,
              child: ListView.builder(
                  itemCount: locationchoice.length,
                  itemBuilder: (context, index) {
                    return LocationChoice(
                        label: locationchoice[index].name,
                        isSelected: locationchoice[index].isSelected,
                        onTap: () {
                          setState(() {
                            locationchoice.forEach((element) {
                              element.isSelected = false;
                            });
                            locChoice = index;
                            locationchoice[index].isSelected = true;
                          });
                          locationchoice.forEach((element) {
                            print(element.isSelected);
                          });
                        });
                  }),
            )),
      ],
    );
  }

  Widget getCustomWidget(BuildContext context) {
    switch (selectedWidget) {
      case 0:
        return getUserNameWidget();
      case 1:
        return getEmailIdWidget();
      case 2:
        return getGenderWidget();
      case 3:
        return getBirthdayWidget();
      case 4:
        return getCategoryWidget();
      case 5:
        return getSubCategoryWidget();
      case 6:
        return getDocumentsWidget(context);
      case 7:
        return getLocationWidget();
    }
    return getUserNameWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        print('hey');
                        setState(() {
                          if (selectedWidget != 0)
                            setState(() {
                              selectedWidget--;
                            });
                        });
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 25,
                      ),
                    ),
                    Expanded(child: Container()),
                    GestureDetector(
                      onTap: () {
                        selectedWidget == 7
                            ? Navigator.pushReplacementNamed(context, homePage)
                            : setState(() {
                                selectedWidget++;
                              });
                      },
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.black,
                        size: 25,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    getCustomWidget(context),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                // Padding(
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       SizedBox.fromSize(
                //         size: Size(56, 56), // button width and height
                //         child: ClipOval(
                //           child: Material(
                //             color: Colors.white, // button color
                //             child: InkWell(
                //               splashColor: Color(0xFFECF89C),
                //               // splash color
                //               onTap: () {
                //                 setState(() {
                //                   if (selectedWidget != 0)
                //                     setState(() {
                //                       selectedWidget--;
                //                     });
                //                 });
                //               },
                //               // button pressed
                //               child: Column(
                //                 mainAxisAlignment: MainAxisAlignment.center,
                //                 children: <Widget>[
                //                   Image(
                //                     image: AssetImage(
                //                       'assets/images/planeArrow.png',
                //                     ),
                //                     height: 32.0,
                //                     width: 22.0,
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ),
                //         ),
                //       ),
                //       // Text(
                //       //   '${selectedWidget + 1}/6',
                //       //   textAlign: TextAlign.center,
                //       //   style: TextStyle(
                //       //     color: Colors.black87,
                //       //     fontSize: 20.0,
                //       //   ),
                //       // ),
                //       SizedBox.fromSize(
                //         size: Size(56, 56), // button width and height
                //         child: ClipOval(
                //           child: Material(
                //             color: Colors.white, // button color
                //             child: InkWell(
                //               splashColor: Color(0xFFECF89C), // splash color
                //               onTap: () {
                //                 selectedWidget == 5
                //                     ? Navigator.pushReplacementNamed(
                //                         context, homePage)
                //                     : setState(() {
                //                         selectedWidget++;
                //                       });
                //               }, // button pressed
                //               child: Column(
                //                 mainAxisAlignment: MainAxisAlignment.center,
                //                 children: <Widget>[
                //                   RotatedBox(
                //                     quarterTurns: 2,
                //                     child: Image(
                //                       image: AssetImage(
                //                         'assets/images/planeArrow.png',
                //                       ),
                //                       height: 32.0,
                //                       width: 22.0,
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Padding(
                //     padding: const EdgeInsets.symmetric(
                //         horizontal: 32, vertical: 16),
                //     child: Container(
                //       height: 20,
                //     )),
                Container(
                  height: 30,
                  width: double.infinity,
                  decoration: BoxDecoration(color: accentBlueLight),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SubCategory extends StatelessWidget {
  final String text;
  const SubCategory({
    @required this.text,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  blurRadius: 4,
                  offset: Offset(0, 4))
            ],
            color: Colors.white,
            border: Border.all(color: Color(0xffCFCFCF), width: 1),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(text),
        ),
      ),
    );
  }
}

class LocationChoice extends StatefulWidget {
  String label;
  bool isSelected;
  Function onTap;
  LocationChoice({
    this.label,
    this.isSelected,
    this.onTap,
    Key key,
  }) : super(key: key);

  @override
  _LocationChoiceState createState() => _LocationChoiceState();
}

class _LocationChoiceState extends State<LocationChoice> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(77, 40, 77, 0),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
            height: 66,
            decoration: BoxDecoration(
                color: widget.isSelected ? Color(0xffE9F98F) : Colors.white,
                border: widget.isSelected
                    ? null
                    : Border.all(color: Color(0xffDFF4F3), width: 1),
                borderRadius: BorderRadius.circular(10),
                shape: BoxShape.rectangle,
                // BoxShape.circle or BoxShape.retangle
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.05),
                      blurRadius: 4.0,
                      offset: Offset(1, 4)),
                ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Text(
                    widget.label,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: widget.isSelected
                            ? Colors.black
                            : Color(0xff8C8FA5)),
                  ),
                  Expanded(child: Container()),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: widget.isSelected ? Colors.black : Color(0xff8C8FA5),
                  )
                ],
              ),
            )),
      ),
    );
  }
}

class Modal {
  String name;
  bool isSelected;

  Modal({this.name, this.isSelected = false});
}
