import 'dart:io';

import 'package:flutter/material.dart';
import 'package:alo_doctor_doctor/widgets/videoPlayer.dart';
import 'package:video_player/video_player.dart';

class FilePlayerWidget extends StatefulWidget {
  final File videoFile;
  FilePlayerWidget(this.videoFile);
  @override
  _FilePlayerWidgetState createState() => _FilePlayerWidgetState();
}

class _FilePlayerWidgetState extends State<FilePlayerWidget> {
  // final File file = File(
  //     '/data/user/0/com.example.video_example/cache/file_picker/big_buck_bunny_720p_10mb.mp4');
  VideoPlayerController controller;

  @override
  void initState() {
    super.initState();

    if (widget.videoFile.existsSync()) {
      controller = VideoPlayerController.file(widget.videoFile)
        ..addListener(() => setState(() {}))
        ..setLooping(true)
        ..initialize().then((_) => controller.play());
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: ElevatedButton(
            style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all(Colors.black)),
            child: Image(
              color: Colors.white,
              image: AssetImage('./assets/images/arrow.png'),
              height: 20,
              width: 20,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Column(
          children: [
            SizedBox(height: 100),
            VideoPlayerWidget(controller: controller),
          ],
        ),
      );
}
