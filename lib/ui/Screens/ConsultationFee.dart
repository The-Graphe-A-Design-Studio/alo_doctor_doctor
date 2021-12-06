import 'package:alo_doctor_doctor/api/login.dart';
import 'package:alo_doctor_doctor/providers/profileProvider.dart';
import 'package:alo_doctor_doctor/utils/Colors.dart';
import 'package:alo_doctor_doctor/utils/MyConstants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:alo_doctor_doctor/utils/styles.dart';

class ConsultationFee extends StatefulWidget {
  @override
  _ConsultationFeeState createState() => _ConsultationFeeState();
}

class _ConsultationFeeState extends State<ConsultationFee> {
  int selectedWidget;
  int select = 0;
  String fee;
  int period;
  bool _isLoading = false;
  bool _isFeePeriodLoading = false;

  submitFee() async {
    setState(() {
      _isLoading = true;
    });

    int doc = await LoginCheck().SetFee(fee);
    print("docfee--$doc");
    Provider.of<ProfileProvider>(context, listen: false).upadateFee(fee);
    print(doc);
    if (doc == 1) {
      Fluttertoast.showToast(
        msg: "Fee is Set",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      print('SetFee');
    } else {
      Fluttertoast.showToast(
        msg: "error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }

    setState(() {
      _isLoading = false;
    });
    // Navigator.pop(context);
  }

  saveFeePeriod() async {
    setState(() {
      _isFeePeriodLoading = true;
    });

    int doc = await LoginCheck().setFeesPeriod(period.toString());
    Provider.of<ProfileProvider>(context, listen: false)
        .upadateFeePeriod(period);
    if (doc == 1) {
      Fluttertoast.showToast(
        msg: "Fee Period Saved",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      // print('SetFee');
    } else {
      Fluttertoast.showToast(
        msg: "error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }

    setState(() {
      _isFeePeriodLoading = false;
    });
    Navigator.pop(context);
  }

  // Widget getConsultMode() {
  //   return Padding(e
  //     padding: const EdgeInsets.all(20.0),
  //     child: Column(
  //       children: [
  //         SizedBox(
  //           height: 10,
  //         ),
  //         GestureDetector(
  //           onTap: () {
  //             setState(() {
  //               select = 1;
  //             });
  //           },
  //           child: Container(
  //             height: 50,
  //             width: double.infinity,
  //             decoration: BoxDecoration(
  //                 color: select == 1 ? Color(0xffE9F98F) : Colors.white,
  //                 border: Border.all(
  //                     color:
  //                         select == 1 ? Color(0xffE9F98F) : Color(0xffDFF4F3),
  //                     width: 1),
  //                 borderRadius: BorderRadius.circular(20)),
  //             child: Center(
  //                 child: Text(
  //               'Voice Calls',
  //               style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
  //             )),
  //           ),
  //         ),
  //         SizedBox(
  //           height: 10,
  //         ),
  //         GestureDetector(
  //           onTap: () {
  //             setState(() {
  //               select = 2;
  //             });
  //           },
  //           child: Container(
  //             height: 50,
  //             width: double.infinity,
  //             decoration: BoxDecoration(
  //                 color: select == 2 ? Color(0xffE9F98F) : Colors.white,
  //                 border: Border.all(
  //                     color:
  //                         select == 2 ? Color(0xffE9F98F) : Color(0xffDFF4F3),
  //                     width: 1),
  //                 borderRadius: BorderRadius.circular(20)),
  //             child: Center(
  //                 child: Text(
  //               'Video Calls',
  //               style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
  //             )),
  //           ),
  //         ),
  //         SizedBox(
  //           height: 10,
  //         ),
  //         GestureDetector(
  //           onTap: () {
  //             setState(() {
  //               select = 3;
  //             });
  //           },
  //           child: Container(
  //             height: 50,
  //             width: double.infinity,
  //             decoration: BoxDecoration(
  //                 color: select == 3 ? Color(0xffE9F98F) : Colors.white,
  //                 border: Border.all(
  //                     color:
  //                         select == 3 ? Color(0xffE9F98F) : Color(0xffDFF4F3),
  //                     width: 1),
  //                 borderRadius: BorderRadius.circular(20)),
  //             child: Center(
  //                 child: Text(
  //               'In Clinic/Offline',
  //               style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
  //             )),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  // Widget getConsultFee() {
  //   return Padding(
  //     padding: const EdgeInsets.all(20.0),
  //     child: Column(
  //       children: [
  //         Text(
  //           select == 1 ? 'Voice' : (select == 2 ? 'Video' : 'Offline'),
  //           style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
  //         )
  //       ],
  //     ),
  //   );
  // }

  // Widget getCustomWidget() {
  //   switch (selectedWidget) {
  //     case 0:
  //       return getConsultMode();
  //     case 1:
  //       return getConsultFee();
  //   }
  //   return getConsultMode();
  // }

  @override
  void initState() {
    selectedWidget = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Consultations Fee',
          style: Styles.regularHeading,
        ),
        centerTitle: true,
        backgroundColor: accentBlueLight,
        leading: backButton(context),
        iconTheme: Theme.of(context).iconTheme,
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Icon(Icons.notifications_none),
        //   ),
        // ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // if you need this
                side: BorderSide(
                  color: Colors.grey.withOpacity(0.4),
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('Please set your consultation fee in USD :'),
                    Consumer<ProfileProvider>(builder: (ctx, data, child) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: TextFormField(
                            onChanged: (value) {
                              fee = value.toString();
                              print(fee);
                            },
                            initialValue: data.currentUser.docFees == null
                                ? ''
                                : data.currentUser.docFees,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      );
                    }),
                    _isLoading
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: accentBlueLight, // background
                              onPrimary: Colors.black, // foreground
                            ),
                            onPressed: () {
                              if (fee == "" || fee == null) {
                                Fluttertoast.showToast(
                                  msg: "Please Enter Fee amount",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                );
                              } else
                                submitFee();
                              // Respond to button press
                            },
                            child: Text('Set Fee'),
                          )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // if you need this
                side: BorderSide(
                  color: Colors.grey.withOpacity(0.4),
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('Please set Patient come back time:'),
                    Consumer<ProfileProvider>(builder: (ctx, data, child) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: TextFormField(
                            onChanged: (value) {
                              period = int.parse(value);
                              print(period);
                            },
                            initialValue: data.currentUser.feesPeriod == null
                                ? ''
                                : data.currentUser.feesPeriod.toString(),
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: "Number of days",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      );
                    }),
                    _isFeePeriodLoading
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: accentBlueLight, // background
                              onPrimary: Colors.black, // foreground
                            ),
                            onPressed: () {
                              saveFeePeriod();
                              // Respond to button press
                            },
                            child: Text('Save'),
                          )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
