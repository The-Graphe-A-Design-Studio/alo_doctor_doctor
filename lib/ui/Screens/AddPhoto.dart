import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../providers/profileProvider.dart';
import 'package:alo_doctor_doctor/utils/MyConstants.dart';
import 'package:alo_doctor_doctor/api/profile.dart';
import 'package:alo_doctor_doctor/utils/Colors.dart';

class AddPhoto extends StatefulWidget {
  @override
  _AddPhotoState createState() => _AddPhotoState();
}

class _AddPhotoState extends State<AddPhoto> {
  ProfileServer serverHandler = ProfileServer();
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  void takePhoto(ImageSource source) async {
    final userHandler = Provider.of<ProfileProvider>(context, listen: false);

    final pickedFile = await _picker.getImage(source: source, imageQuality: 20);

    try {
      // print('picked file path ------------ ${pickedFile?.path}');
      if (pickedFile != null) {
        setState(() {
          _isLoading = true;
        });
        await userHandler.postProfilePic(File(pickedFile.path));

        setState(() {
          _imageFile = pickedFile;
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Profile picture updated successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // print('eroor in takephoto ------------- ${e.toString()}');
      return showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text('An Error Occured!'),
              content: Text(
                e.toString(),
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
              ],
            );
          });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _imageFile = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: backButton(context),
        title: Column(
          children: [
            Text(
              'Add Profile Picture',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
        centerTitle: true,
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
                  child: _isLoading
                      ? Column(
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Uploading..",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            )
                          ],
                        )
                      : Container(
                          child: Stack(
                            children: [
                              Consumer<ProfileProvider>(
                                builder: (context, userData, _) {
                                  print((userData.userProfileDetails
                                                  .profilePicPath !=
                                              "" ||
                                          userData.userProfileDetails
                                                  .profilePicPath !=
                                              null) &&
                                      _imageFile == null);
                                  return Container(
                                    width: 177,
                                    height: 177,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: ((userData.userProfileDetails
                                                                .profilePicPath !=
                                                            "" &&
                                                        userData.userProfileDetails
                                                                .profilePicPath !=
                                                            null) &&
                                                    _imageFile == null)
                                                ? NetworkImage(
                                                    'https://www.alodoctor-care.com/app-backend/public${userData.userProfileDetails.profilePicPath}')
                                                : (_imageFile != null)
                                                    ? Image.file(File(
                                                            _imageFile.path))
                                                        .image
                                                    : AssetImage(
                                                        './assets/images/user.png'),

                                            // (_imageFile == null &&
                                            //         userData.currentUser
                                            //                 .profilePicPath ==
                                            //             null)
                                            //     ?(AssetImage('./assets/images/user.png')):
                                            //      (userData.currentUser
                                            //                 .profilePicPath !=
                                            //             null)
                                            //         ?(NetworkImage('https://www.alodoctor-care.com/app-backend/public${userData.currentUser.profilePicPath}') ):

                                            //         FileImage(
                                            //             File(_imageFile.path),
                                            //           ) ,
                                            fit: BoxFit.fill),
                                        border: Border.all(width: 0),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(200),
                                        ),
                                        color: Color(0xffC4C4C4)),
                                  );
                                },
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
                      Navigator.of(context).pop();
                      takePhoto(
                        ImageSource.camera,
                      );
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
                      Navigator.of(context).pop();

                      takePhoto(
                        ImageSource.gallery,
                      );
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
}
