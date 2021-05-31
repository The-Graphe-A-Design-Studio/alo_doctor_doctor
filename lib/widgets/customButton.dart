import 'package:alo_doctor_doctor/utils/Colors.dart';
import 'package:alo_doctor_doctor/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String btnText;
  final Function onPressed;
  final Color backgroundColor;
  final double btnWidth;

  CustomButton(
      {this.btnText, this.onPressed, this.backgroundColor, this.btnWidth});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        highlightColor: Color(0xFFA7F4E8),
        splashColor: Color(0xFFECF89C),
        onTap: onPressed,
        child: Container(
          height: 50,
          width: btnWidth ?? double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: accentBlueLight,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 0.1,
                  blurRadius: 10, // changes position of shadow
                ),
              ],
              color: backgroundColor ?? Colors.white),
          child: Stack(
            children: [
              Center(
                child: Text(
                  btnText ?? "Button",
                  textAlign: TextAlign.center,
                  style: Styles.buttonTextBlack,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
