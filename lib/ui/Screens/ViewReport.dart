import 'package:flutter/material.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:alo_doctor_doctor/widgets/reportViewer.dart';
import '../../utils/Colors.dart';
import 'package:alo_doctor_doctor/utils/styles.dart';
import 'package:alo_doctor_doctor/ui/screens/PhotoViewer.dart';
import 'package:alo_doctor_doctor/utils/MyConstants.dart';

class ViewReport extends StatelessWidget {
  List reportList;

  ViewReport({Key key, this.reportList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Report',
          style: Styles.regularHeading,
        ),
        centerTitle: true,
        backgroundColor: accentBlueLight,
        leading: ElevatedButton(
          style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              backgroundColor: MaterialStateProperty.all(accentBlueLight)),
          child: Image(
            image: AssetImage('./assets/images/arrow.png'),
            height: 20,
            width: 20,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.all(15.0),
                itemCount: reportList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1 / 1,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemBuilder: (ctx, index) {
                  // var nowParam =
                  //     DateFormat('yyyyddMMHHmmss').format(DateTime.now());

                  return InkWell(
                    onTap: () {
                      print(reportList[index]["file_path"]);
                      Navigator.of(context).pushNamed(photoViewer,
                          arguments:
                              PhotoViewer(reportList[index]["file_path"]));
                      // showDialog(
                      //     context: context,
                      //     builder: (context) => reportViewer(
                      //         docPath: reportList[index]["file_path"]));
                    },
                    child: Container(
                      child: Image.network(
                        'https://developers.thegraphe.com/alodoctor/public${reportList[index]["file_path"]}',
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
