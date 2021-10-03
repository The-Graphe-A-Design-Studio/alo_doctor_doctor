import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/Colors.dart';

class PhotoViewer extends StatelessWidget {
  final String imgPath;
  PhotoViewer(this.imgPath);

  @override
  Widget build(BuildContext context) {
    print('https://developers.thegraphe.com/alodoctor/public$imgPath');
    return Scaffold(
      backgroundColor: Colors.white,
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
        child: Image.network(
            'https://developers.thegraphe.com/alodoctor/public$imgPath'),
      ),
    );
  }
}
