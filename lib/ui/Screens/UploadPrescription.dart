import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:alo_doctor_doctor/api/login.dart';
import 'package:alo_doctor_doctor/models/doctor.dart';
import 'package:alo_doctor_doctor/ui/Screens/Video/NetworkVideoPlayer.dart';
import 'package:alo_doctor_doctor/ui/Screens/Video/FileVideoPlayer.dart';

import 'package:alo_doctor_doctor/utils/Colors.dart';

import 'package:alo_doctor_doctor/utils/MyConstants.dart';
import 'package:alo_doctor_doctor/utils/styles.dart';
import 'package:alo_doctor_doctor/widgets/photoViewer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import '../../utils/styles.dart';
import '../../utils/Colors.dart';
import '../../utils/MyConstants.dart';
import 'package:alo_doctor_doctor/utils/EnvironmentVariables.dart';

class UploadPrescription extends StatefulWidget {
  final String id;
  UploadPrescription(this.id);

  @override
  _UploadPrescriptionState createState() => _UploadPrescriptionState();
}

class _UploadPrescriptionState extends State<UploadPrescription> {
  bool _isLoading = false;
  List prescriptionList = [];
  List<VideoModel> videoList = [];
  List<PhotoModel> photoList = [];
  var error;

  String videoPrescription;
  int uploaded = 0;
  final ImagePicker _picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    setData();
    // setState(() {
    //   _isLoading = true;
    // });
    // try {} catch (e) {
    //   setState(() {
    //     _isLoading = false;
    //     error = e;
    //   });
    // }
  }

  void setData() async {
    prescriptionList.clear();
    videoList.clear();
    photoList.clear();
    await LoginCheck().getBookingsById(int.parse(widget.id)).then((value) {
      setState(() {
        prescriptionList = value[0]["prescription"];
        print("prescription list --> $prescriptionList");
        if (prescriptionList != null) {
          prescriptionList.forEach((element) {
            if (element["file_name"].split(".")[1] == "mp4")
              videoList.add(VideoModel(
                  "network",
                  VideoPlayerController.network(
                      "$baseUrl${element["file_path"]}")
                    ..initialize().then((value) => setState(() {
                          print("done");
                        })),
                  element["file_path"],
                  element["file_name"],
                  false));
            else
              photoList.add(PhotoModel("network", element["file_path"],
                  element["file_name"], false));
          });
          print(videoList);
          print(photoList);
          // if (prescriptionList.length == 1 &&
          //     prescriptionList[0]["file_name"].split(".")[1] == "mp4") {
          //   _controller = VideoPlayerController.network(
          //       "$baseUrl${prescriptionList[0]["file_path"]}")
          //     ..initialize().then((_) {
          //       setState(() {
          //         videoPrescription = prescriptionList[0]["file_path"];
          //         _isLoading = false;
          //       });
          //     });
          // } else {
          //   videoPrescription = null;
          _isLoading = false;
          // }
        } else
          _isLoading = false;
      });
    });
  }

  void pickFile(bool isVideo) async {
    List<File> selected = List<File>.empty(growable: true);
    XFile videoFile;
    List pickedFile;
    if (isVideo) {
      videoFile = await _picker.pickVideo(source: ImageSource.gallery);
      if (videoFile == null) return;

      selected.insert(0, File(videoFile.path));
      setState(() {
        _isLoading = true;
      });
    } else {
      pickedFile = await _picker.pickMultiImage(imageQuality: 20);
      if (pickedFile == null) return;

      for (int i = 0; i < pickedFile.length; i++) {
        selected.insert(i, File(pickedFile[i].path));
      }
      // pickedFile.forEach((element) {
      //   photoList.add(PhotoModel("file",element.path));
      // });
      setState(() {
        // photoList = [...selected];
        _isLoading = true;
      });
    }

    print('yoo');

    int success = await LoginCheck().PrescriptionUpload(selected, widget.id);
    print(success);
    if (success == 1) {
      setState(() {
        uploaded = 1;
        // if (isVideo) {
        //   videoList.add(VideoModel(
        //       "file",
        //       setVideoFileController(File(videoFile.path)),
        //       videoFile.path,
        //       "",
        //       false));
        // } else {
        //   pickedFile.forEach((element) {
        //     photoList.add(PhotoModel("file", element.path, "", false));
        //   });
        // }
        _isLoading = false;
      });
      Fluttertoast.showToast(
        msg: "Uploaded successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      setData();
    } else {
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(
        msg: "File Size must be less than 100mb",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    print(success);
  }

  VideoPlayerController setVideoFileController(File videoFilePath) {
    VideoPlayerController _controller;
    setState(() {
      _controller = VideoPlayerController.file(videoFilePath)
        ..initialize().then((_) {
          print("Done file controller initialization");
        });
    });
    return _controller;
  }

  Widget deleteButton(Function onTap) {
    return Positioned(
      right: -9,
      top: -8,
      child: GestureDetector(
        child: Container(
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Center(
            child: Icon(
              Icons.delete,
              color: Color.fromRGBO(250, 128, 114, 1),
              size: 15,
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Upload Prescription',
            style: Styles.regularHeading,
          ),
          centerTitle: true,
          backgroundColor: accentBlueLight,
          leading: backButton(context),
          iconTheme: Theme.of(context).iconTheme,
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : (error != null)
                ? Center(
                    child: Text('Something went wrong...'),
                  )
                : RefreshIndicator(
                    backgroundColor: Colors.grey.shade800,
                    color: Colors.white,
                    onRefresh: () async {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          height: 50,
                          child: AppBar(
                            elevation: 0,
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            bottom: TabBar(
                              indicatorWeight: 2,
                              indicatorColor: accentYellow,
                              labelColor: Colors.black,
                              labelStyle:
                                  TextStyle(fontWeight: FontWeight.bold),
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              tabs: <Widget>[
                                Tab(
                                  text: 'Video',
                                ),
                                Tab(
                                  text: 'Photo',
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              RefreshIndicator(
                                backgroundColor: Colors.grey.shade800,
                                color: Colors.white,
                                onRefresh: () {},
                                child: videoList.isEmpty
                                    ? Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                              icon: Icon(
                                                  Icons.add_circle_outlined),
                                              iconSize: 29,
                                              onPressed: () {
                                                pickFile(true);
                                              },
                                            ),
                                            Text(
                                              "Upload Videos",
                                              style: Styles.buttonTextBlackBold,
                                            ),
                                          ],
                                        ),
                                      )
                                    : Column(
                                        children: [
                                          Expanded(
                                            child: Stack(
                                              children: [
                                                GridView.builder(
                                                    physics:
                                                        BouncingScrollPhysics(),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    itemCount: videoList.length,
                                                    gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 3,
                                                      childAspectRatio: 1 / 1,
                                                      crossAxisSpacing: 15,
                                                      mainAxisSpacing: 15,
                                                    ),
                                                    itemBuilder: (ctx, index) {
                                                      return Stack(
                                                        clipBehavior: Clip.none,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              videoList[index]
                                                                          .type ==
                                                                      "file"
                                                                  ? Navigator.of(
                                                                          context)
                                                                      .pushNamed(
                                                                      filevideo,
                                                                      arguments:
                                                                          FilePlayerWidget(
                                                                        File(videoList[index]
                                                                            .path),
                                                                      ),
                                                                    )
                                                                  : Navigator.pushNamed(
                                                                      context,
                                                                      networkVideo,
                                                                      arguments:
                                                                          NetworkPlayerWidget(
                                                                              videoList[index].path));
                                                            },
                                                            child: videoList[
                                                                        index]
                                                                    .isDeleting
                                                                ? Center(
                                                                    child: Text(
                                                                        "Deleting.."),
                                                                  )
                                                                : Container(
                                                                    child: videoList[index]
                                                                            .controller
                                                                            .value
                                                                            .isInitialized
                                                                        ? VideoPlayer(
                                                                            videoList[index].controller)
                                                                        : Center(
                                                                            child:
                                                                                CircularProgressIndicator(),
                                                                          )),
                                                          ),
                                                          deleteButton(
                                                            () async {
                                                              print(videoList[
                                                                      index]
                                                                  .fileName);
                                                              setState(() {
                                                                videoList[index]
                                                                        .isDeleting =
                                                                    true;
                                                              });
                                                              var response = await LoginCheck()
                                                                  .deletePrescription(
                                                                      int.parse(
                                                                          widget
                                                                              .id),
                                                                      videoList[
                                                                              index]
                                                                          .fileName);
                                                              if (response ==
                                                                  1) {
                                                                setState(() {
                                                                  videoList.remove(
                                                                      videoList[
                                                                          index]);
                                                                });
                                                              } else {
                                                                setState(() {
                                                                  videoList[index]
                                                                          .isDeleting =
                                                                      false;
                                                                });
                                                                Fluttertoast
                                                                    .showToast(
                                                                  msg:
                                                                      "Something went wrong, try again!",
                                                                  toastLength: Toast
                                                                      .LENGTH_SHORT,
                                                                  gravity:
                                                                      ToastGravity
                                                                          .CENTER,
                                                                );
                                                              }
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    }),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: Container(
                                                    margin: EdgeInsets.all(25),
                                                    child: IconButton(
                                                      icon: Icon(Icons
                                                          .add_circle_outlined),
                                                      iconSize: 29,
                                                      onPressed: () {
                                                        pickFile(true);
                                                      },
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                              ),
                              RefreshIndicator(
                                backgroundColor: Colors.grey.shade800,
                                color: Colors.white,
                                onRefresh: () {},
                                child: photoList.isEmpty
                                    ? Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                              icon: Icon(
                                                  Icons.add_circle_outlined),
                                              iconSize: 29,
                                              onPressed: () {
                                                pickFile(false);
                                              },
                                            ),
                                            Text(
                                              "Upload Photos",
                                              style: Styles.buttonTextBlackBold,
                                            ),
                                          ],
                                        ),
                                      )
                                    : Column(
                                        children: [
                                          Expanded(
                                            child: Stack(
                                              children: [
                                                GridView.builder(
                                                    physics:
                                                        BouncingScrollPhysics(),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    itemCount: photoList.length,
                                                    gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 3,
                                                      childAspectRatio: 1 / 1,
                                                      crossAxisSpacing: 15,
                                                      mainAxisSpacing: 15,
                                                    ),
                                                    itemBuilder: (ctx, index) {
                                                      return Stack(
                                                        clipBehavior: Clip.none,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              Navigator.of(context).pushNamed(
                                                                  photoViewer,
                                                                  arguments: PhotoViewer(
                                                                      photoList[
                                                                              index]
                                                                          .path,
                                                                      photoList[index].type ==
                                                                              "file"
                                                                          ? false
                                                                          : true));
                                                            },
                                                            child: Container(
                                                              height: double
                                                                  .infinity,
                                                              width: double
                                                                  .infinity,
                                                              // color: Colors.red,
                                                              child: photoList[
                                                                          index]
                                                                      .isDeleting
                                                                  ? Center(
                                                                      child: Text(
                                                                          "Deleting.."),
                                                                    )
                                                                  : FadeInImage(
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      placeholder:
                                                                          AssetImage(
                                                                              'assets/images/placeholder.jpg'),
                                                                      image: photoList[index].type ==
                                                                              "file"
                                                                          ? Image
                                                                              .file(
                                                                              File(photoList[index].path),
                                                                              fit: BoxFit.cover,
                                                                            ).image
                                                                          : Image.network(
                                                                              "$baseUrl${photoList[index].path}",
                                                                              fit: BoxFit.cover,
                                                                            ).image,
                                                                    ),
                                                            ),
                                                          ),
                                                          deleteButton(
                                                            () async {
                                                              print(photoList[
                                                                      index]
                                                                  .fileName);
                                                              setState(() {
                                                                photoList[index]
                                                                        .isDeleting =
                                                                    true;
                                                              });
                                                              var response = await LoginCheck()
                                                                  .deletePrescription(
                                                                      int.parse(
                                                                          widget
                                                                              .id),
                                                                      photoList[
                                                                              index]
                                                                          .fileName);
                                                              if (response ==
                                                                  1) {
                                                                setState(() {
                                                                  photoList.remove(
                                                                      photoList[
                                                                          index]);
                                                                });
                                                              } else {
                                                                setState(() {
                                                                  photoList[index]
                                                                          .isDeleting =
                                                                      false;
                                                                });
                                                                Fluttertoast
                                                                    .showToast(
                                                                  msg:
                                                                      "Something went wrong, try again!",
                                                                  toastLength: Toast
                                                                      .LENGTH_SHORT,
                                                                  gravity:
                                                                      ToastGravity
                                                                          .CENTER,
                                                                );
                                                              }
                                                            },
                                                          )
                                                        ],
                                                      );
                                                    }),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: Container(
                                                    margin: EdgeInsets.all(25),
                                                    child: IconButton(
                                                      icon: Icon(Icons
                                                          .add_circle_outlined),
                                                      iconSize: 29,
                                                      onPressed: () {
                                                        pickFile(false);
                                                      },
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
      ),
    );
  }
}

class VideoModel {
  String type;
  String path;
  VideoPlayerController controller;
  String fileName;
  bool isDeleting;
  VideoModel(
      this.type, this.controller, this.path, this.fileName, this.isDeleting);
}

class PhotoModel {
  String type;
  String path;
  String fileName;
  bool isDeleting;
  PhotoModel(this.type, this.path, this.fileName, this.isDeleting);
}
