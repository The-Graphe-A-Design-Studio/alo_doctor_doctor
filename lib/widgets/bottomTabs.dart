import 'package:alo_doctor_doctor/utils/Colors.dart';
import 'package:flutter/material.dart';

class BottomTabs extends StatefulWidget {
  final int selectedTab;
  final Function(int) tabPressed;
  BottomTabs({this.selectedTab, this.tabPressed});

  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    _selectedTab = widget.selectedTab ?? 0;

    return Container(
      decoration: BoxDecoration(color: accentBlueLight, boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2.0,
            blurRadius: 3.0,
            offset: Offset(0, -1))
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomTabButtons(
            imagePath: "assets/images/tab_home.png",
            selected: _selectedTab == 0,
            onPressed: () {
              widget.tabPressed(0);
            },
          ),
          BottomTabButtons(
            imagePath: "assets/images/tab_second.png",
            selected: _selectedTab == 1,
            onPressed: () {
              widget.tabPressed(1);
            },
          ),
          BottomTabButtons(
            imagePath: "assets/images/tab_search.png",
            selected: _selectedTab == 2,
            onPressed: () {
              widget.tabPressed(2);
              print('Tab Pressed');
            },
          ),
          BottomTabButtons(
            imagePath: "assets/images/tab_fourth.png",
            selected: _selectedTab == 3,
            onPressed: () {
              widget.tabPressed(3);
            },
          ),
          BottomTabButtons(
            imagePath: "assets/images/user.png",
            selected: _selectedTab == 4,
            onPressed: () {
              widget.tabPressed(4);
            },
          ),
        ],
      ),
    );
  }
}

class BottomTabButtons extends StatelessWidget {
  final String imagePath;
  final bool selected;
  final Function onPressed;
  BottomTabButtons({this.imagePath, this.selected, this.onPressed});

  @override
  Widget build(BuildContext context) {
    bool _isSelected = selected ?? false;

    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: _isSelected ? Colors.black87 : Colors.transparent,
                    width: 2.0))),
        child: Image(
          image: AssetImage(imagePath ?? "assets/images/tab_home.png"),
          color: _isSelected ? Colors.black87 : Colors.black,
          width: 22,
          height: 22,
        ),
      ),
    );
  }
}
