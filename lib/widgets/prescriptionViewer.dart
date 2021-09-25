import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';

class PrescriptionViewer extends StatefulWidget {
  String docPath;
  PrescriptionViewer({Key, key, this.docPath}) : super(key: key);

  @override
  _PrescriptionViewerState createState() => _PrescriptionViewerState();
}

class _PrescriptionViewerState extends State<PrescriptionViewer> {
  Matrix4 matrix = Matrix4.identity();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: 580,
        width: 600,
        // padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 10),
        // margin: EdgeInsets.only(top: 45),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
            ]),
        child: MatrixGestureDetector(
          onMatrixUpdate: (Matrix4 m, Matrix4 tm, Matrix4 sm, Matrix4 rm) {
            setState(() {
              matrix = m;
            });
          },
          child: Transform(
            transform: matrix,
            child: Image.network(
              'https://developers.thegraphe.com/alodoctor/public${widget.docPath}',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
