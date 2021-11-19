import 'dart:io';

import 'package:alo_doctor_doctor/api/login.dart';
import 'package:alo_doctor_doctor/models/doctor.dart';
import 'package:alo_doctor_doctor/providers/profileProvider.dart';
import 'package:alo_doctor_doctor/utils/Colors.dart';
import 'package:alo_doctor_doctor/utils/MyConstants.dart';
import 'package:alo_doctor_doctor/utils/styles.dart';
import 'package:alo_doctor_doctor/widgets/customDropDown.dart';
import 'package:alo_doctor_doctor/widgets/documentUpload.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/date_picker_theme.dart';
import 'package:flutter_holo_date_picker/widget/date_picker_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  bool isEdit;
  RegisterPage(this.isEdit);
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Details userDetails;

  TextEditingController nameController;
  TextEditingController qualificationController;
  TextEditingController expController;
  TextEditingController phoneController;

  List<int> uploaded = [0, 0, 0, 0, 0];
  int selectedWidget;
  String name;
  String qualification = "";
  String exp = "";
  String phone = "";
  String concode = '91';
  String selectedGender = '';
  String selectedBloodGroup = '';
  String birthday = "";

  File _imageFile;
  List<String> categories;
  List<String> scategories;
  List<String> selectedscat = [];
  List<int> scatid;
  final ImagePicker _picker = ImagePicker();
  String selectedIsMarried = '';
  DateTime _selectedBirthday;
  List<bool> selected = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  List<Modal> uploadList = [];
  List<Modal> locationchoice = [];
  int locChoice;
  // int isUpdate;
  String chosenCategory = null;

  @override
  void initState() {
    super.initState();
    loadCat();
    selectedWidget = 0;
    if (widget.isEdit) {
      final profileData = Provider.of<ProfileProvider>(context, listen: false);
      userDetails = profileData.currentUser;
      print(userDetails.docExperience);
      print(exp);
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String formatted = formatter.format(userDetails.dob);
      birthday = formatted;
      selectedGender = userDetails.gender;
      phone = userDetails.phone.toString();
      chosenCategory = userDetails.category;
      concode = userDetails.conCode.toString();
      exp = userDetails.docExperience.toString();
      qualification = userDetails.docQualification;
      nameController = TextEditingController(
          text: userDetails.name == null ? name : userDetails.name);
      qualificationController = TextEditingController(
          text: userDetails.docQualification == null
              ? qualification
              : userDetails.docQualification);
      expController = TextEditingController(
          text: userDetails.docExperience == null
              ? exp
              : userDetails.docExperience.toString());
      phoneController = TextEditingController(
          text: userDetails == null
              ? phone
              : (userDetails.phone == null
                  ? phone
                  : userDetails.phone.toString()));

      userDetails.documents[0].file != null ? uploaded[0] = 1 : uploaded[0] = 0;
      userDetails.documents[1].file != null ? uploaded[1] = 1 : uploaded[1] = 0;
      userDetails.documents[2].file != null ? uploaded[2] = 1 : uploaded[2] = 0;
      userDetails.documents[3].file != null ? uploaded[3] = 1 : uploaded[3] = 0;
    }
    uploadList.add(Modal(
        name: 'National Id (FRONT)',
        isSelected: widget.isEdit
            ? userDetails.documents[0].file != null
                ? true
                : false
            : false));
    uploadList.add(Modal(
        name: 'National Id (BACK)',
        isSelected: widget.isEdit
            ? userDetails.documents[1].file != null
                ? true
                : false
            : false));
    uploadList.add(Modal(
        name: 'Passport (Front)',
        isSelected: widget.isEdit
            ? userDetails.documents[2].file != null
                ? true
                : false
            : false));
    uploadList.add(Modal(
        name: 'Passport (Back)',
        isSelected: widget.isEdit
            ? userDetails.documents[3].file != null
                ? true
                : false
            : false));
    uploadList.add(Modal(
        name: 'Degree',
        isSelected: widget.isEdit
            ? userDetails.documents[4].file != null
                ? true
                : false
            : false));
    // locationchoice.add(Modal(name: 'Use my Location', isSelected: widget.isEdit? userDetails.documents.length>=1?true: false:false));
    // locationchoice.add(Modal(name: 'Pick a city', isSelected: widget.isEdit? userDetails.documents.length>=1?true: false:false));
  }

  void loadCat() async {
    categories = await LoginCheck().getCategories();

    // check  if this screen is used for registration or profile edit
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // setState(() {
    //   isUpdate = prefs.getInt('update');
    // });
  }

  Future loadSubCat() async {
    scategories = await LoginCheck().getSub(chosenCategory);
    print('subcategories--------$scategories');
    return scategories;
  }

  Future loadSubCatid() async {
    scatid = await LoginCheck().getSubId(chosenCategory);

    return scatid;
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
          child: TextFormField(
            controller: nameController,
            onChanged: (value) {
              name = value;
            },
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

  Widget getUserQualificationWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'What are your Qualifications?',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 22.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(64, 40, 64, 0),
          child: TextFormField(
            controller: qualificationController,
            onChanged: (value) {
              qualification = value;
            },
            decoration: InputDecoration(
                hintText: 'Enter your qualifications',
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0)),
            style: Styles.buttonTextBlack,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget getUserExperienceWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'How many years of experience you have?',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 22.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(64, 40, 64, 0),
          child: TextFormField(
            controller: expController,
            // keyboardType: TextInputType.number,
            onChanged: (value) {
              exp = value;
            },
            decoration: InputDecoration(
                hintText: 'Experience in years',
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0)),
            style: Styles.buttonTextBlack,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget getPhoneWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'What is your phone number?',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 22.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 45, 0, 0),
                child: CountryCodePicker(
                  hideMainText: true,
                  onChanged: (e) {
                    setState(() {
                      String code = e.toString();
                      concode = e.toString().substring(1, code.length);
                      print(concode);
                      // concode = e.toString().substring(1, code.length);
                    });
                  },
                  initialSelection: concode == "" ? 'IN' : "+$concode",
                  showCountryOnly: false,
                  favorite: ['+91', 'IN'],
                ),
              ),
              Container(
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                  child: TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      phone = value;
                    },
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Text is empty';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: 'Phone',
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 16.0)),
                    style: Styles.buttonTextBlack,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
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
              print(selectedGender);
              print(selectedGender == 'male');
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
              print(selectedGender);
              print(selectedGender == 'female');
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
              print(selectedGender);
              print(selectedGender == 'other');
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
        chosenCategory = choosen;
        print(chosenCategory);
      });
    }

    List items = categories.map<DropdownMenuItem<String>>((String value) {
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
            value: chosenCategory,
            isEnabled: true,
          ),
        ),
      ],
    );
  }

  Widget getSubCategoryWidget() {
    print('sub');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('SubCategories'),
          ),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            direction: Axis.horizontal,
            children: [
              Wrap(
                children: [
                  for (var i in scategories)
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        setState(() {
                          selected[scategories.indexOf(i)] =
                              !selected[scategories.indexOf(i)];
                        });

                        print(selectedscat);
                        if (selectedscat.contains(
                            scatid[scategories.indexOf(i)].toString())) {
                          print('remove');
                          print(scategories.indexOf(i).toString());
                          selectedscat.removeWhere((item) =>
                              item ==
                              scatid[scategories.indexOf(i)].toString());
                        } else {
                          print('insert');
                          selectedscat
                              .add(scatid[scategories.indexOf(i)].toString());
                        }
                      },
                      child: SubCategory(
                        text: i,
                        selected: selected[scategories.indexOf(i)],
                      ),
                    )
                ],
              ),
            ],
          ),
          scategories.length == 0 ? Text('No subcategories found') : Text('')
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
              firstDate: DateTime(1901, 01, 01),
              lastDate: DateTime(2030, 1, 1),
              initialDate: _selectedBirthday ?? DateTime(1991, 10, 12),
              dateFormat: "dd-MMM-yyyy",
              locale: DatePicker.localeFromString('en'),
              onChange: (DateTime newDate, _) {
                _selectedBirthday = newDate;
                final DateFormat formatter = DateFormat('yyyy-MM-dd');
                final String formatted = formatter.format(newDate);
                birthday = formatted;
              },
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
              height: 300,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: uploadList.length,
                  itemBuilder: (context, index) {
                    return documentUpload(
                        label: uploadList[index].name,
                        uploaded: uploaded[index],
                        isSelected: uploadList[index].isSelected,
                        onTap: () {
                          setState(() {
                            uploadList.forEach((element) {
                              element.isSelected = false;
                            });

                            uploadList[index].isSelected = true;
                          });
                          showModalBottomSheet(
                            context: context,
                            builder: ((builder) => bottomSheet(index)),
                          );
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

  void takePhoto(ImageSource source, int index) async {
    final pickedFile = await _picker.getImage(source: source, imageQuality: 30);
    File selected = File(pickedFile.path);
    setState(() {
      _imageFile = selected;
    });
    int success = await LoginCheck().DocUpload(_imageFile, index);
    if (success == 1) {
      Fluttertoast.cancel();
      Fluttertoast.showToast(
        msg: "Uploaded successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      setState(() {
        uploaded[index] = 1;
      });
    } else {
      Fluttertoast.showToast(
        msg: "Size should be below 500kb",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    print(success);
  }

  Widget bottomSheet(int index) {
    return Container(
      height: 150,
      width: double.infinity,
      color: Color(0xffDFF4F3),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Column(
              children: [
                Text(
                  'Camera',
                  style: TextStyle(
                      color: Color(0xff8C8FA5),
                      fontWeight: FontWeight.w400,
                      fontSize: 13),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);

                      takePhoto(ImageSource.camera, index);
                    },
                    child: Container(
                      height: 111,
                      width: 147,
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.grey,
                        size: 50,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(width: 0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          color: Color(0xffC4C4C4)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Column(
              children: [
                Text(
                  'Gallery',
                  style: TextStyle(
                      color: Color(0xff8C8FA5),
                      fontWeight: FontWeight.w400,
                      fontSize: 13),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      takePhoto(ImageSource.gallery, index);
                    },
                    child: Container(
                      height: 111,
                      width: 147,
                      child: Icon(
                        Icons.image,
                        color: Colors.grey,
                        size: 50,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(width: 0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          color: Color(0xffC4C4C4)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 4.0),
          //   child: Column(
          //     children: [
          //       Text(
          //         'Delete',
          //         style: TextStyle(
          //             color: Color(0xff8C8FA5),
          //             fontWeight: FontWeight.w400,
          //             fontSize: 13),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: GestureDetector(
          //           onTap: () {},
          //           child: Container(
          //             height: 111,
          //             width: 147,
          //             child: Icon(
          //               Icons.restore_from_trash_outlined,
          //               color: Colors.grey,
          //               size: 50,
          //             ),
          //             decoration: BoxDecoration(
          //                 border: Border.all(width: 0),
          //                 borderRadius: BorderRadius.all(
          //                   Radius.circular(20),
          //                 ),
          //                 color: Color(0xffC4C4C4)),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  _register() async {
    print(selectedGender);
    print(birthday);
    print(name);
    print(phone);
    Details updatedUser = Details();
    updatedUser.dob = DateTime.parse(birthday);
    updatedUser.category = chosenCategory;
    updatedUser.conCode = int.parse(concode);
    updatedUser.name = name;
    updatedUser.phone = int.parse(phone);
    updatedUser.gender = selectedGender;
    updatedUser.docExperience = exp == "" ? 0 : int.parse(exp);
    updatedUser.docQualification = qualification ?? "";
    Provider.of<ProfileProvider>(context, listen: false)
        .postProfileData(updatedUser);
    // await LoginCheck().Register(selectedGender, birthday, name, qualification,
    //     exp, phone, chosenCategory, concode);
    await LoginCheck().setsub(selectedscat);
    widget.isEdit
        ? Navigator.of(context).pop()
        : Navigator.pushReplacementNamed(context, homePage);
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
        return getPhoneWidget();
      case 2:
        return getUserQualificationWidget();
      case 3:
        return getUserExperienceWidget();
      case 4:
        return getGenderWidget();
      case 5:
        return getBirthdayWidget();
      case 6:
        return getCategoryWidget();
      case 7:
        return scategories == null
            ? Center(child: CircularProgressIndicator())
            : getSubCategoryWidget();
      case 8:
        return getDocumentsWidget(context);
      // case 7:
      //   return getLocationWidget();
    }
    return getUserNameWidget();
  }

  @override
  Widget build(BuildContext context) {
    print(concode);
    if (name == null && userDetails != null) {
      name = userDetails.name;
    }
    if (qualification == null && userDetails != null) {
      qualification = userDetails.docQualification;
    }
    if (exp == null && userDetails != null) {
      exp = userDetails.docExperience == null
          ? ""
          : userDetails.docExperience.toString();
    }
    if (_selectedBirthday == null && userDetails != null) {
      _selectedBirthday = userDetails.dob;
    }
    if (phone == null && userDetails != null) {
      phone = userDetails.phone.toString();
    }
    Details dummy = new Details();
    final profileData = Provider.of<ProfileProvider>(context);
    userDetails = profileData.currentUser;
    print(userDetails == null);
    nameController = TextEditingController(
        text: userDetails == null
            ? name
            : userDetails.name == null
                ? name
                : userDetails.name);
    qualificationController = TextEditingController(
        text: userDetails == null
            ? qualification
            : userDetails.docQualification == null
                ? qualification
                : userDetails.docQualification);
    expController = TextEditingController(
        text: userDetails == null
            ? exp
            : userDetails.docExperience == null
                ? exp
                : userDetails.docExperience.toString());
    phoneController = TextEditingController(
        text: userDetails == null
            ? phone
            : (userDetails.phone == null
                ? phone
                : userDetails.phone.toString()));
    // selectedGender =userDetails == null
    //         ?selectedGender:userDetails.gender == null
    //     ? selectedGender
    //     :  userDetails.gender;
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
                    if (selectedWidget > 0)
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
                    if (widget.isEdit && selectedWidget == 0)
                      GestureDetector(
                        onTap: () {
                          print('hey');
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: 25,
                        ),
                      ),
                    Expanded(child: Container()),
                    GestureDetector(
                      onTap: () async {
                        selectedWidget == 8
                            ? !uploaded.contains(1)
                                ? Fluttertoast.showToast(
                                    msg: "Please upload documents",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                  )
                                : _register()
                            : setState(() {
                                print(selectedWidget);
                                if (selectedWidget == 0) {
                                  print(nameController.text);
                                  if (nameController.text.isNotEmpty == false) {
                                    Fluttertoast.showToast(
                                      msg: "Name cannot be null",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                    );
                                  } else {
                                    selectedWidget++;
                                  }
                                } else if (selectedWidget == 1) {
                                  if (phoneController.text.length == 0) {
                                    Fluttertoast.showToast(
                                      msg: "Please Enter phone number",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                    );
                                  } else if (phoneController.text.length !=
                                      10) {
                                    Fluttertoast.showToast(
                                      msg: "Please enter valid phone number",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                    );
                                  } else {
                                    selectedWidget++;
                                  }
                                } else if (selectedWidget == 5) {
                                  if (_selectedBirthday == null) {
                                    Fluttertoast.showToast(
                                      msg: "Please set your birth date",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                    );
                                  } else {
                                    selectedWidget++;
                                  }
                                } else if (selectedWidget == 6) {
                                  loadSubCat().then((doctor) {
                                    setState(() {
                                      this.scategories = doctor;
                                    });
                                  });

                                  loadSubCatid().then((doctor) {
                                    setState(() {
                                      this.scatid = doctor;
                                    });
                                  });
                                  if (chosenCategory != null)
                                    selectedWidget++;
                                  else
                                    Fluttertoast.showToast(
                                      msg: "Please select Category",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                    );
                                } else if (selectedWidget == 7) {
                                  print('sub category--- $selectedscat');
                                  if (selectedscat.isNotEmpty)
                                    selectedWidget++;
                                  else
                                    Fluttertoast.showToast(
                                      msg: "Please select subcategory",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                    );
                                }
                                // } else if (selectedWidget == 6) {
                                //   bool check =
                                //       uploaded.every((element) => element == 1);
                                //   if (check == true) {
                                //     selectedWidget++;
                                //   } else {
                                //     Fluttertoast.showToast(
                                //       msg: "please upload all documents",
                                //       toastLength: Toast.LENGTH_SHORT,
                                //       gravity: ToastGravity.CENTER,
                                //     );
                                //   }
                                // }
                                else {
                                  selectedWidget++;
                                }
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

class SubCategory extends StatefulWidget {
  final String text;
  bool selected;
  SubCategory({
    @required this.text,
    @required this.selected,
    Key key,
  }) : super(key: key);

  @override
  _SubCategoryState createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
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
            color: widget.selected ? Colors.lightGreen : Colors.white,
            border: Border.all(color: Color(0xffCFCFCF), width: 1),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(widget.text),
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
