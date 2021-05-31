import 'package:flutter/material.dart';

import '../utils/colors.dart';

class SlotItem extends StatelessWidget {
  bool isSelected;
  final String time;
  SlotItem(this.isSelected, this.time);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: isSelected ? accentYellow : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          style: BorderStyle.solid,
          color: accentBlueLight,
        ),
      ),
      child: Center(
        child: Text(
          time,
          style: isSelected ? TextStyle(fontWeight: FontWeight.bold) : null,
        ),
      ),
    );
  }
}
