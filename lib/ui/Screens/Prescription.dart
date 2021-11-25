import 'dart:io';

import 'package:alo_doctor_doctor/api/login.dart';
import 'package:alo_doctor_doctor/models/doctor.dart';
import 'package:alo_doctor_doctor/ui/Screens/Video/NetworkVideoPlayer.dart';
import 'package:alo_doctor_doctor/ui/Screens/Video/FileVideoPlayer.dart';

import 'package:alo_doctor_doctor/utils/Colors.dart';

import 'package:alo_doctor_doctor/utils/MyConstants.dart';
import 'package:alo_doctor_doctor/utils/styles.dart';
import 'package:alo_doctor_doctor/widgets/photoViewer.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:alo_doctor_doctor/widgets/prescriptionViewer.dart';
import 'package:video_player/video_player.dart';

class Prescription extends StatefulWidget {
  final String id;
  // In the constructor, require a RecordObject.
  Prescription(this.id);
  @override
  _PrescriptionState createState() => _PrescriptionState();
}

class _PrescriptionState extends State<Prescription> {
  List<File> _imageFile = [];
  List<File> _videoFile = [];
  VideoPlayerController _controller;

  // PickedFile _imageFile;
  List prescriptionList;
  String videoPrescription;
  bool _isLoading = false;
  int uploaded = 0;
  final ImagePicker _picker = ImagePicker();

  void setData() async {
    await LoginCheck().getBookingsById(int.parse(widget.id)).then((value) {
      setState(() {
        prescriptionList = value[0]["prescription"];
        print("prescription list --> $prescriptionList");
        if (prescriptionList != null) {
          if (prescriptionList.length == 1 &&
              prescriptionList[0]["file_name"].split(".")[1] == "mp4") {
            _controller = VideoPlayerController.network(
                "$baseUrl${prescriptionList[0]["file_path"]}")
              ..initialize().then((_) {
                setState(() {
                  videoPrescription = prescriptionList[0]["file_path"];
                  _isLoading = false;
                });
              });
          } else {
            videoPrescription = null;
            _isLoading = false;
          }
        } else
          _isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    setData();
    // loadData().then((doctor) {
    //   print(doctor);
    //   setState(() {
    //     this.doctor = doctor;
    //   });
    // });
  }

  // Future loadData() async {
  //   doctor = await LoginCheck().UserInfo();
  //   return doctor;
  // }

  void takePhoto(ImageSource source, bool isVideo) async {
    print(source);
    if (isVideo) {
      XFile pickedFile = await _picker.pickVideo(source: source);
      List<File> selected = List<File>.empty(growable: true);

      selected.insert(0, File(pickedFile.path));
      setVideoFileController(File(pickedFile.path));
      setState(() {
        _videoFile = selected;
        _isLoading = true;
      });
    } else {
      List pickedFile = await _picker.pickMultiImage(imageQuality: 20);
      // final pickedFile = await _picker.getImage(source: source);

      List<File> selected = List<File>.empty(growable: true);
      for (int i = 0; i < pickedFile.length; i++) {
        selected.insert(i, File(pickedFile[i].path));
      }
      setState(() {
        _imageFile = selected;
        _isLoading = true;
      });
    }

    print(widget.id);
    print('yoo');

    int success = await LoginCheck()
        .PrescriptionUpload(isVideo ? _videoFile : _imageFile, widget.id);
    if (success == 1) {
      Fluttertoast.showToast(
        msg: "Uploaded successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      setState(() {
        uploaded = 1;
        _isLoading = false;
      });
    } else {
      Fluttertoast.showToast(
        msg: "File Size must be less than 200kb",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    print(success);
  }

  void setVideoFileController(File videoFilePath) {
    setState(() {
      _controller = VideoPlayerController.file(videoFilePath)
        ..initialize().then((_) {
          print("Done file controller initialization");
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    // print("prescription screen-------" + widget.id);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: backButton(context),
        // actions: [
        //   if (prescriptionList != null)
        //     IconButton(
        //         // child: Padding(
        //         //   padding: const EdgeInsets.only(right: 3),
        //         //   child: const Text(
        //         //     "Replace",
        //         //     style: TextStyle(
        //         //         color: Colors.black, fontWeight: FontWeight.bold),
        //         //   ),
        //         // ),
        //         icon: Icon(
        //           Icons.find_replace_rounded,
        //           color: Colors.black,
        //         ),
        //         onPressed: () {
        //           // print(bookingId);
        //           prescriptionList.clear();
        //           showModalBottomSheet(
        //             context: context,
        //             builder: ((builder) => bottomSheet()),
        //           );
        //         })
        // ],
        title: Column(
          children: [
            Text(
              'Upload Prescription',
              style: Styles.regularHeading,
            )
          ],
        ),
        centerTitle: true,
        backgroundColor: accentBlueLight,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : (prescriptionList == null || prescriptionList.isEmpty)
              ? (_imageFile.isEmpty && _videoFile.isEmpty)
                  ? SingleChildScrollView(
                      child: Padding(
                      padding: const EdgeInsets.only(bottom: 40.0, top: 60),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 30, horizontal: 30.0),
                              child: Center(
                                child: Container(
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: 177,
                                        height: 177,
                                        child: _isLoading
                                            ? Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              )
                                            : Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '',
                                                      style: TextStyle(
                                                          fontSize: 31,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
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
                                                image:
                                                    // _imageFile == null
                                                    //     ?
                                                    AssetImage(
                                                  './assets/images/upload.jpg',
                                                ),
                                                // : Image.file(File(_imageFile))
                                                //     .image,
                                                fit: BoxFit.fill),
                                            border: Border.all(width: 0),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            color: Color(0xffC4C4C4)),
                                      ),
                                      Positioned(
                                        bottom: 10,
                                        right: 10,
                                        child: GestureDetector(
                                          onTap: () async {
                                            // final result = await FilePicker
                                            //     .platform
                                            //     .pickFiles();
                                            showModalBottomSheet(
                                              context: context,
                                              builder: ((builder) =>
                                                  bottomSheet()),
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
                              ))
                        ],
                      ),
                    ))
                  : Column(
                      children: [
                        Expanded(
                          child: GridView.builder(
                              physics: BouncingScrollPhysics(),
                              padding: const EdgeInsets.all(10.0),
                              itemCount: _videoFile.isNotEmpty
                                  ? _videoFile.length
                                  : _imageFile.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 1 / 1,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                              ),
                              itemBuilder: (ctx, index) {
                                return InkWell(
                                  onTap: () {
                                    _videoFile.isNotEmpty
                                        ? Navigator.of(context).pushNamed(
                                            filevideo,
                                            arguments:
                                                FilePlayerWidget(_videoFile[0]))
                                        : Navigator.of(context).pushNamed(
                                            photoViewer,
                                            arguments: PhotoViewer(
                                                _imageFile[index].path, false));
                                  },
                                  child: Container(
                                    // height:
                                    //     MediaQuery.of(context).size.height * 2,
                                    // width: MediaQuery.of(context).size.width * 2,
                                    // padding: EdgeInsets.all(10),
                                    child: _videoFile.isNotEmpty
                                        ? VideoPlayer(_controller)
                                        : Image.file(
                                            File(_imageFile[index].path),
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                );
                              }),
                        )
                      ],
                    )
              : Column(
                  children: [
                    Expanded(
                        child: GridView.builder(
                            physics: BouncingScrollPhysics(),
                            padding: const EdgeInsets.all(15.0),
                            itemCount: prescriptionList.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1 / 1,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                            ),
                            itemBuilder: (ctx, index) {
                              // var nowParam =
                              //     DateFormat('yyyyddMMHHmmss').format(DateTime.now());

                              print(prescriptionList.length.toString() +
                                  prescriptionList[index]["file_path"]);
                              return InkWell(
                                onTap: videoPrescription != null
                                    ? () {
                                        print("hello");
                                        Navigator.pushNamed(
                                            context, networkVideo,
                                            arguments: NetworkPlayerWidget(
                                                videoPrescription));
                                      }
                                    : () {
                                        Navigator.of(context).pushNamed(
                                            photoViewer,
                                            arguments: PhotoViewer(
                                                prescriptionList[index]
                                                    ["file_path"],
                                                true));
                                        // showDialog(
                                        //     context: context,
                                        //     builder: (context) => PrescriptionViewer(
                                        //         docPath: prescriptionList[index]
                                        //             ["file_path"]));
                                      },
                                child: Container(
                                  child: videoPrescription != null
                                      ? _controller.value.isInitialized
                                          ? VideoPlayer(_controller)
                                          : Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                      : Image.network(
                                          'https://developers.thegraphe.com/alodoctor/public${prescriptionList[index]["file_path"]}',
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              );
                            }))
                  ],
                ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: prescriptionList != null
          ? Container(
              margin: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text(
                              "Alert",
                              style: Styles.regularHeading,
                            ),
                            content: Text("Previous uploads will get deleted."),
                            actions: [
                              TextButton(
                                child: Text("OK"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  prescriptionList.clear();
                                  //  Navigator.of(context).pop();
                                  // takePhoto(ImageSource.gallery, false);
                                  showModalBottomSheet(
                                    context: context,
                                    builder: ((builder) => bottomSheet()),
                                  );
                                },
                              )
                            ],
                          ));
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed))
                        return accentYellow;
                      return accentBlueLight;
                    })),
                child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    width: double.infinity,
                    child: Text(
                      'Upload Again',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )),
              ),
            )
          : Container(),
    );
  }

  // void takePhoto(ImageSource source) async {
  //   // final userHandler = Provider.of<ProfileProvider>(context, listen: false);

  //   final pickedFile = await _picker.getImage(source: source);

  //   try {
  //     // print('picked file path ------------ ${pickedFile?.path}');
  //     if (pickedFile != null) {
  //       setState(() {
  //         _isLoading = true;
  //       });
  //       await LoginCheck().PrescriptionUpload(File(pickedFile.path), widget.id);

  //       setState(() {
  //         _imageFile = pickedFile;
  //         _isLoading = false;
  //       });
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           duration: Duration(seconds: 3),
  //           content: Text('Prescription Uploaded successfully!'),
  //           backgroundColor: Colors.green,
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     // print('eroor in takephoto ------------- ${e.toString()}');
  //     return showDialog(
  //         context: context,
  //         builder: (ctx) {
  //           return AlertDialog(
  //             title: Text('An Error Occured!'),
  //             content: Text(
  //               e.toString(),
  //               style: TextStyle(
  //                 fontSize: 20,
  //               ),
  //             ),
  //             actions: <Widget>[
  //               TextButton(
  //                 child: Text('Ok'),
  //                 onPressed: () {
  //                   Navigator.of(context).pop(false);
  //                 },
  //               ),
  //             ],
  //           );
  //         });
  //   }
  // }

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
                  'Video',
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

                      takePhoto(ImageSource.gallery, true);
                    },
                    child: Container(
                      height: 111,
                      width: 147,
                      child: Icon(
                        Icons.video_collection,
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
                  'Photos',
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
                      takePhoto(ImageSource.gallery, false);
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
