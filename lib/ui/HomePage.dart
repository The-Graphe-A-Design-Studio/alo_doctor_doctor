import 'package:alo_doctor_doctor/Tab/Dashboard.dart';
import 'package:alo_doctor_doctor/utils/Colors.dart';
import 'package:alo_doctor_doctor/widgets/bottomTabs.dart';
import 'package:alo_doctor_doctor/widgets/navigationDrawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _tabPageController;
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _tabPageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _tabPageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: NavigationDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Image(
              image: AssetImage(
                'assets/images/drawer.png',
              ),
              height: 20.0,
              width: 20.0,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: <Widget>[
          new IconButton(
            icon: Image(
              image: AssetImage(
                'assets/images/location.png',
              ),
              height: 20.0,
              width: 20.0,
            ),
            onPressed: () {},
          ),
        ],
        title: Column(
          children: [
            Text(
              'Current Location',
              style: TextStyle(fontSize: 12, color: Colors.black87),
            ),
            Text(
              'Mumbai',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
        centerTitle: true,
        backgroundColor: accentBlueLight,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _tabPageController,
              onPageChanged: (num) {
                setState(() {
                  _selectedTab = num;
                });
              },
              children: [
                DashboardTab(),
                DashboardTab(),
                DashboardTab(),
                DashboardTab(),
                DashboardTab(),
              ],
            ),
          ),
          BottomTabs(
            selectedTab: _selectedTab,
            tabPressed: (num) {
              setState(() {
                _tabPageController.animateToPage(num,
                    duration: Duration(milliseconds: 250),
                    curve: Curves.easeInCubic);
              });
            },
          ),
        ],
      ),
    );
  }
}
