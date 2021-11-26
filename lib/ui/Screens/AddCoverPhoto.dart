import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../providers/profileProvider.dart';
import 'package:alo_doctor_doctor/utils/MyConstants.dart';
import 'package:alo_doctor_doctor/api/profile.dart';
import 'package:alo_doctor_doctor/utils/Colors.dart';
import 'package:alo_doctor_doctor/models/doctor.dart';

class AddCoverPhoto extends StatefulWidget {
  @override
  _AddCoverPhotoState createState() => _AddCoverPhotoState();
}

class _AddCoverPhotoState extends State<AddCoverPhoto> {
  ProfileServer serverHandler = ProfileServer();
  Details userProfileDetails = Details();
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _descriptionController = TextEditingController();
  String bannerPath;
  void takePhoto(ImageSource source) async {
    final userHandler = Provider.of<ProfileProvider>(context, listen: false);

    final pickedFile = await _picker.getImage(source: source, imageQuality: 20);

    try {
      // print('picked file path ------------ ${pickedFile?.path}');
      if (pickedFile != null) {
        // setState(() {
        //   _isLoading = true;
        // });
        // await userHandler.postProfilePic(File(pickedFile.path));

        // setState(() {
        //   _imageFile = pickedFile;
        //   _isLoading = false;
        // });
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('Cover Photo uploaded successfully!'),
        //     backgroundColor: Colors.green,
        //   ),
        // );
        setState(() {
          _imageFile = pickedFile;
        });
      }
    } catch (e) {
      // setState(() {
      //   _isLoading = false;
      // });
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
  void initState() {
    super.initState();
    setData();
  }

  void setData() async {
    setState(() {
      _isLoading = true;
    });
    userProfileDetails = await serverHandler.getUserProfile();
    bannerPath = userProfileDetails.docBannerPath;
    _descriptionController.text = userProfileDetails.docBannerDescription;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _imageFile = null;
  }

  void upload(PickedFile cover, String desc) async {
    print(cover == null);

    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        setState(() {
          _isLoading = true;
        });
        await serverHandler.postCoverPhoto(
            cover == null ? null : File(cover.path), desc);

        setState(() {
          // _imageFile = pickedFile;
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Cover Photo uploaded successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red.shade400,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: backButton(context),
        centerTitle: true,
        title: Column(
          children: [
            Text(
              'Add Cover Photo',
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
          padding: const EdgeInsets.only(bottom: 40.0, top: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 30.0),
                child: Center(
                  child: _isLoading
                      ? Column(
                          children: [
                            Container(
                                height: 177,
                                child:
                                    Center(child: CircularProgressIndicator())),
                            SizedBox(
                              height: 5,
                            ),
                            // Text(
                            //   "Uploading..",
                            //   style: TextStyle(
                            //       fontWeight: FontWeight.bold, fontSize: 18),
                            // )
                          ],
                        )
                      : Container(
                          child: Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: 177,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: (userProfileDetails
                                                        .docBannerPath !=
                                                    null &&
                                                _imageFile == null)
                                            ? NetworkImage(
                                                '$baseUrl${userProfileDetails.docBannerPath}')
                                            : (_imageFile != null)
                                                ? Image.file(
                                                        File(_imageFile.path))
                                                    .image
                                                : NetworkImage(
                                                    "https://news.aut.ac.nz/__data/assets/image/0006/92328/placeholder-image10.jpg"),

                                        // (_imageFile == null &&
                                        //         userData.currentUser
                                        //                 .profilePicPath ==
                                        //             null)
                                        //     ?(AssetImage('./assets/images/user.png')):
                                        //      (userData.currentUser
                                        //                 .profilePicPath !=
                                        //             null)
                                        //         ?(NetworkImage('$baseUrl${userData.currentUser.profilePicPath}') ):

                                        //         FileImage(
                                        //             File(_imageFile.path),
                                        //           ) ,
                                        fit: BoxFit.fill),
                                    border: Border.all(width: 0),
                                    // borderRadius: BorderRadius.all(
                                    //   Radius.circular(200),
                                    // ),
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
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        maxLines: 15,
                        // key: _formKeyDesc,
                        controller: _descriptionController,
                        // initialValue: _descriptionController.text,
                        validator: (value) => value.trim().isEmpty
                            ? "This field is required"
                            : null,
                        // onSaved: (value) => _descriptionController.text = value,
                        decoration: InputDecoration(
                          hintText: "Add description",
                          // hintStyle: TextStyle(color: Colors.blueAccent),
                          // border: InputBorder.none,
                          // suffixIcon: Icon(Icons.edit),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10)),
                              backgroundColor:
                                  MaterialStateProperty.all(accentBlueLight),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.black)),
                          child: Text("Upload"),
                          onPressed: () {
                            upload(_imageFile, _descriptionController.text);
                          }
                          // () {
                          //   if (_formKeyDesc.currentState.validate()) {
                          //     _formKeyDesc.currentState.save();
                          //     upload(_imageFile, _descriptionController.text);
                          //   }
                          // },
                          )
                    ],
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
