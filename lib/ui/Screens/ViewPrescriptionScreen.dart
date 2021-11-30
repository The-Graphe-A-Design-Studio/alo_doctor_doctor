import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:alo_doctor_doctor/widgets/prescriptionViewer.dart';
import '../../utils/Colors.dart';
import 'package:alo_doctor_doctor/utils/styles.dart';
import 'package:alo_doctor_doctor/utils/MyConstants.dart';
import 'package:alo_doctor_doctor/ui/Screens/Prescription.dart';

class ViewPrescription extends StatelessWidget {
  List prescriptionList;
  final String bookingId;

  ViewPrescription({Key key, this.prescriptionList, this.bookingId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Prescription',
          style: Styles.regularHeading,
        ),
        centerTitle: true,
        backgroundColor: accentBlueLight,
        actions: [
          IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.black,
              ),
              onPressed: () {
                print(bookingId);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Prescription(bookingId)),
                );
              })
        ],
        leading: backButton(context),
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.all(15.0),
                itemCount: prescriptionList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1 / 1,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemBuilder: (ctx, index) {
                  // var nowParam =
                  //     DateFormat('yyyyddMMHHmmss').format(DateTime.now());

                  print(prescriptionList.length.toString() +
                      prescriptionList[index]["file_path"]);
                  return InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => PrescriptionViewer(
                              docPath: prescriptionList[index]["file_path"]));
                    },
                    child: Container(
                      child: Image.network(
                        'https://www.alodoctor-care.com/app-backend/public${prescriptionList[index]["file_path"]}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
