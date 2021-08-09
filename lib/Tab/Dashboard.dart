import 'package:alo_doctor_doctor/utils/MyConstants.dart';
import 'package:alo_doctor_doctor/widgets/AppointmentMini.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:search_widget/search_widget.dart';

class DashboardTab extends StatefulWidget {
  @override
  _DashboardTabState createState() => _DashboardTabState();
}

final List<String> imgList = [
  'https://post.medicalnewstoday.com/wp-content/uploads/2020/08/Doctors_For_Men-732x549-thumbnail-1-732x549.jpg',
  'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/types-of-doctors-1600114658.jpg',
  'https://www.expatica.com/app/uploads/2018/11/find-a-doctor-abroad.jpg',
  'https://s01.sgp1.cdn.digitaloceanspaces.com/article/50036-jwjwvpytvt-1598150714.jpg'
];

final List<Widget> imageSliders = imgList
    .map((item) => Container(
  child: Container(
    margin: EdgeInsets.all(5.0),
    child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            Image.network(item, fit: BoxFit.cover, width: 1000.0),
            // Positioned(
            //   bottom: 0.0,
            //   left: 0.0,
            //   right: 0.0,
            //   child: Container(
            //     decoration: BoxDecoration(
            //       gradient: LinearGradient(
            //         colors: [
            //           Color.fromARGB(200, 0, 0, 0),
            //           Color.fromARGB(0, 0, 0, 0)
            //         ],
            //         begin: Alignment.bottomCenter,
            //         end: Alignment.topCenter,
            //       ),
            //     ),
            //     padding: EdgeInsets.symmetric(
            //         vertical: 10.0, horizontal: 20.0),
            //     child: Text(
            //       'No. ${imgList.indexOf(item) + 1} image',
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 20.0,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        )),
  ),
)).toList();

class _DashboardTabState extends State<DashboardTab> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      // Padding(
      //   padding:
      //       const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
      //   child: Text(
      //     'Hello Dr.Ramya G S',
      //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      //   ),
      // ),
      // Padding(
      //   padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      //   child: ClipRRect(
      //     borderRadius: BorderRadius.circular(20),
      //     child: SearchWidget(
      //       dataList: [],
      //       textFieldBuilder:
      //           (TextEditingController controller, FocusNode focusNode) {
      //         return Container(
      //           margin: EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 5),
      //           height: 50,
      //           width: double.infinity,
      //           child: TextField(
      //             autocorrect: true,
      //             decoration: InputDecoration(
      //               prefixIcon: Padding(
      //                 padding: EdgeInsets.all(0.0),
      //                 child: Icon(
      //                   Icons.search,
      //                   color: Colors.grey,
      //                 ), // icon is 48px widget.
      //               ),
      //               contentPadding:
      //                   EdgeInsets.symmetric(horizontal: 26, vertical: 13),
      //               hintText: 'Search',
      //               hintStyle: TextStyle(color: Colors.grey),
      //               filled: true,
      //               fillColor: Colors.white70,
      //               enabledBorder: OutlineInputBorder(
      //                 borderRadius: BorderRadius.all(Radius.circular(12.0)),
      //                 borderSide:
      //                     BorderSide(color: Colors.grey.shade300, width: 2),
      //               ),
      //               focusedBorder: OutlineInputBorder(
      //                 borderRadius: BorderRadius.all(Radius.circular(10.0)),
      //                 borderSide: BorderSide(color: Colors.grey.shade300),
      //               ),
      //             ),
      //           ),
      //         );
      //       },
      //     ),
      //   ),
      // ),
      Container(
        padding: EdgeInsets.only(top: 8),
        child: CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 2.0,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
          ),
          items: imageSliders,
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Upcoming Appointments',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, appointmentScreen);
                  },
                  child: Text('See all'),
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    // padding: MaterialStateProperty.all(EdgeInsets.all(0))
                    // backgroundColor: MaterialStateProperty.all(Colors.black),
                    foregroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return Colors.blue;
                        return Colors.black;
                      },
                    ),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                )
              ],
            ),
            AppointmentMini(
              Name: 'Akash Bose',
              time: '4:30',
              date: '03 Aug, 2021',
              isSelected: false,
              onTap: () {
                Navigator.pushNamed(context, videoCallingScreen);
              },
            ),
            AppointmentMini(
              Name: 'Priya Shetty',
              time: '5:30',
              date: '03 Aug, 2021',
              isSelected: false,
              onTap: () {},
            ),
            AppointmentMini(
              Name: 'Pooja Bhel',
              time: '6:30',
              date: '03 Aug, 2021',
              isSelected: false,
              onTap: () {},
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10, left: 30, right: 25, bottom: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Manage',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            // TextButton(
            //   onPressed: () {},
            //   child: Text('See all'),
            //   style: ButtonStyle(
            //     overlayColor: MaterialStateProperty.all(Colors.transparent),
            //     // padding: MaterialStateProperty.all(EdgeInsets.all(0))
            //     // backgroundColor: MaterialStateProperty.all(Colors.black),
            //     foregroundColor: MaterialStateProperty.resolveWith<Color>(
            //       (Set<MaterialState> states) {
            //         if (states.contains(MaterialState.pressed))
            //           return Colors.blue;
            //         return Colors.black;
            //       },
            //     ),
            //     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            //   ),
            // )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(30, 10, 30, 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Categories('Appointments', () {
              Navigator.pushNamed(context, appointmentScreen);
            }, 'appointments'),
            Categories('Consultation', () {
              Navigator.pushNamed(context, consultFee);
            }, 'consultation'),
            Categories('Slots', () {
              Navigator.pushNamed(context, consultSched);
            }, 'calendar'),
          ],
        ),
      ),
      // Padding(
      //   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Categories('Reminders', () {
      //         Navigator.pushNamed(context, reminderScreen);
      //       }, 'reminder'),
      //       Categories('Records', () {
      //         Navigator.pushNamed(context, recordScreen);
      //       }, 'record'),
      //       Categories('Payments', () {
      //         Navigator.pushNamed(context, paymentScreen);
      //       }, 'payments'),
      //     ],
      //   ),
      // ),
    ]);
  }
}

Widget Categories(String catName, ontap, String catIcon) {
  return ElevatedButton(
    onPressed: ontap,
    style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed))
              return Color(0xFFECF89C);
            return Colors.white;
          },
        ),
        foregroundColor: MaterialStateProperty.all(Colors.black87),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        shadowColor: MaterialStateProperty.all(Colors.grey.shade300),
        padding: MaterialStateProperty.all(
          const EdgeInsets.only(left: 6, right: 6, top: 5, bottom: 5),
        )),
    child: Container(
      height: 70,
      width: 75,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(
            image: AssetImage('./assets/images/$catIcon.png'),
            height: 40,
            width: 38,
            fit: BoxFit.contain,
          ),
          Text(
            catName,
            style: TextStyle(fontSize: 10),
          ),
        ],
      ),
    ),
  );
}
