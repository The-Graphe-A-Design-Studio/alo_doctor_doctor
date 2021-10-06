import 'package:flutter/material.dart';

import '../utils/colors.dart';

class SlotItem extends StatelessWidget {
  int isBooked;
  final String time;
  bool isSelected;
  SlotItem(this.isBooked, this.time, this.isSelected);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: (isBooked != 0)
            ? Colors.grey.shade300
            : (isSelected)
            ? accentYellow
            : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          style: BorderStyle.solid,
          color: accentBlueLight,
        ),
      ),
      child: Center(
        child: Text(
          time,
          style: (isBooked != 0)
              ? TextStyle(color: Colors.grey.shade700, fontSize: 15)
              : (isSelected)
              ? TextStyle(fontWeight: FontWeight.bold, fontSize: 15)
              : TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}