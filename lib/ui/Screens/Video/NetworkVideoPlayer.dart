import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'package:alo_doctor_doctor/widgets/videoPlayer.dart';
import 'package:alo_doctor_doctor/utils/MyConstants.dart';

class NetworkPlayerWidget extends StatefulWidget {
  String networkVideo;
  NetworkPlayerWidget(this.networkVideo);
  @override
  _NetworkPlayerWidgetState createState() => _NetworkPlayerWidgetState();
}

class _NetworkPlayerWidgetState extends State<NetworkPlayerWidget> {
  // final textController = TextEditingController(text: urlLandscapeVideo);
  VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    print(widget.networkVideo);
    controller = VideoPlayerController.network("$baseUrl${widget.networkVideo}")
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => controller.play());
  }

  @override
  void dispose() {
    controller.dispose();
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
        body: Container(
          // alignment: Alignment.center,
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 100),
                VideoPlayerWidget(controller: controller),
                // buildTextField(),
              ],
            ),
          ),
        ),
      );

  // Widget buildTextField() => Container(
  //       padding: EdgeInsets.all(32),
  //       child: Row(
  //         children: [
  //           Expanded(
  //             child: TextFieldWidget(
  //               controller: textController,
  //               hintText: 'Enter Video Url',
  //             ),
  //           ),
  //           const SizedBox(width: 12),
  //           FloatingActionButtonWidget(
  //             onPressed: () {
  //               if (textController.text.trim().isEmpty) return;
  //             },
  //           ),
  //         ],
  //       ),
  //     );
}
