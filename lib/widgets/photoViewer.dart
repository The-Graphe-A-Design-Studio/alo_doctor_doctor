import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:alo_doctor_doctor/utils/EnvironmentVariables.dart';

class PhotoViewer extends StatelessWidget {
  final String imgPath;
  bool isNetwork;
  PhotoViewer(this.imgPath, this.isNetwork);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
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
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: Center(
        child: PhotoView(
          imageProvider: isNetwork
              ? NetworkImage('$baseUrl$imgPath')
              : Image.file(
                  File(imgPath),
                  fit: BoxFit.cover,
                ).image,
        ),
        // child: Image.network('$baseUrl${widget.imgPath}'),
      ),
    );
  }
}
