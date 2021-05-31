import 'dart:io';

import 'package:alo_doctor_doctor/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPhoto extends StatefulWidget {
  @override
  _AddPhotoState createState() => _AddPhotoState();
}

class _AddPhotoState extends State<AddPhoto> {
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
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
          padding: const EdgeInsets.only(bottom: 40.0, top: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 30.0),
                child: Center(
                  child: Container(
                    child: Stack(
                      children: [
                        Container(
                          width: 177,
                          height: 177,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Text(
                                //   'Add',
                                //   style: TextStyle(
                                //       fontSize: 31,
                                //       fontWeight: FontWeight.w400),
                                // ),
                                // Text(
                                //   'photo',
                                //   style: TextStyle(
                                //       fontSize: 31,
                                //       fontWeight: FontWeight.w400),
                                // ),
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: _imageFile == null
                                      ? AssetImage(
                                          './assets/images/user.png',
                                        )
                                      : FileImage(
                                          File(_imageFile.path),
                                        ),
                                  fit: BoxFit.fill),
                              border: Border.all(width: 0),
                              borderRadius: BorderRadius.all(
                                Radius.circular(200),
                              ),
                              color: Color(0xffC4C4C4)),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: ((builder) => bottomSheet()),
                              );
                            },
                            child: Container(
                              height: 35,
                              width: 35,
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.grey,
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(width: 0),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(200),
                                  ),
                                  color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Widget bottomSheet() {
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
                      takePhoto(ImageSource.camera);
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
                      takePhoto(ImageSource.gallery);
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
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Column(
              children: [
                Text(
                  'Delete',
                  style: TextStyle(
                      color: Color(0xff8C8FA5),
                      fontWeight: FontWeight.w400,
                      fontSize: 13),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 111,
                      width: 147,
                      child: Icon(
                        Icons.restore_from_trash_outlined,
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
        ],
      ),
    );
  }
}
