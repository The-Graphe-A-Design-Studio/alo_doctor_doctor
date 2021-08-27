import 'package:alo_doctor_doctor/Tab/Dashboard.dart';
import 'package:alo_doctor_doctor/providers/profileProvider.dart';
import 'package:alo_doctor_doctor/utils/Colors.dart';
import 'package:alo_doctor_doctor/widgets/navigationDrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  void didChangeDependencies() {
    super.didChangeDependencies();

    Provider.of<ProfileProvider>(context, listen: false).setProfile();
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
                'assets/images/notification_icon.png',
              ),
              height: 20.0,
              width: 20.0,
            ),
            onPressed: () {},
          ),
        ],
        title: Consumer<ProfileProvider>(builder: (context, profileData, _) {

          print('profileData ${profileData}');

          print('profileData.getUserName ${profileData.getUserName}');

          return Column(
            children: [
              Text(
                'Hello',
                style: TextStyle(fontSize: 12, color: Colors.black87),
              ),
              if (profileData != null)
                Text(
                  profileData.getUserName ?? 'Doctor',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                )
            ],
          );
        }),
        centerTitle: true,
        backgroundColor: accentBlueLight,
      ),
      body: DashboardTab(),
      // body: Column(
      //   children: [
      //     Expanded(
      //       child: PageView(
      //         controller: _tabPageController,
      //         onPageChanged: (num) {
      //           setState(() {
      //             _selectedTab = num;
      //           });
      //         },
      //         children: [
      //           DashboardTab(),
      //           DashboardTab(),
      //           DashboardTab(),
      //           DashboardTab(),
      //           DashboardTab(),
      //         ],
      //       ),
      //     ),
      //     BottomTabs(
      //       selectedTab: _selectedTab,
      //       tabPressed: (num) {
      //         setState(() {
      //           _tabPageController.animateToPage(num,
      //               duration: Duration(milliseconds: 250),
      //               curve: Curves.easeInCubic);
      //         });
      //       },
      //     ),
      //   ],
      // ),
    );
  }
}
