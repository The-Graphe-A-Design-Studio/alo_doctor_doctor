import 'package:alo_doctor_doctor/widgets/AppointmentMini.dart';
import 'package:flutter/material.dart';
import 'package:search_widget/search_widget.dart';

class DashboardTab extends StatefulWidget {
  @override
  _DashboardTabState createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Padding(
        padding:
            const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
        child: Text(
          'Hello Dr.Ramya G S',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SearchWidget(
            dataList: [],
            textFieldBuilder:
                (TextEditingController controller, FocusNode focusNode) {
              return Container(
                margin: EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 5),
                height: 50,
                width: double.infinity,
                child: TextField(
                  autocorrect: true,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ), // icon is 48px widget.
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 26, vertical: 13),
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white70,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide:
                          BorderSide(color: Colors.grey.shade300, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: Text(
              'Upcoming Appointments',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
          ),
          AppointmentMini(Name: 'Akash Bose', time: '4:30'),
          AppointmentMini(Name: 'Priya Shetty', time: '5:30'),
          AppointmentMini(Name: 'Pooja Bhel', time: '6:30'),
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10, left: 30, right: 25, bottom: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Manage',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            TextButton(
              onPressed: () {},
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
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Categories('Appointments', () {}, 'appointments'),
            Categories('Consultation', () {}, 'consultation'),
            Categories('Calendar', () {}, 'calendar'),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Categories('Reminders', () {}, 'reminder'),
            Categories('Records', () {}, 'record'),
            Categories('Payments', () {}, 'payments'),
          ],
        ),
      ),
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
