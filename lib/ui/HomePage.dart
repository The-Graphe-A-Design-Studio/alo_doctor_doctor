import 'package:alo_doctor_doctor/Tab/Dashboard.dart';
import 'package:alo_doctor_doctor/providers/profileProvider.dart';
import 'package:alo_doctor_doctor/utils/Colors.dart';
import 'package:alo_doctor_doctor/widgets/navigationDrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alo_doctor_doctor/utils/MyConstants.dart';
import 'package:alo_doctor_doctor/utils/styles.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _tabPageController;
  int _selectedTab = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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

    // Provider.of<ProfileProvider>(context, listen: false).setProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
        // actions: <Widget>[
        //   new IconButton(
        //     icon: Image(
        //       image: AssetImage(
        //         'assets/images/notification_icon.png',
        //       ),
        //       height: 20.0,
        //       width: 20.0,
        //     ),
        //     onPressed: () {},
        //   ),
        // ],
        title: Consumer<ProfileProvider>(builder: (context, profileData, _) {
          return profileData.userProfileDetails == null
              ? Text('')
              : Column(
                  children: [
                    Text(
                      'Hello',
                      style: TextStyle(fontSize: 12, color: Colors.black87),
                    ),
                    Text(
                      profileData.getUserName == null
                          ? "Loading.."
                          : profileData.getUserName.split(" ").length > 2
                              ? profileData.getUserName.split(" ")[0] +
                                  " " +
                                  profileData.getUserName.split(" ")[1]
                              : profileData.getUserName,
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
