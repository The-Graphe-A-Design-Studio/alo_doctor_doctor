import 'package:alo_doctor_doctor/widgets/photoViewer.dart';
import 'package:flutter/material.dart';
import '../../utils/Colors.dart';
import 'package:alo_doctor_doctor/utils/styles.dart';
import 'package:alo_doctor_doctor/utils/MyConstants.dart';

class ViewReport extends StatelessWidget {
  List reportList;
  String rDescription;
  ViewReport({Key key, this.reportList, this.rDescription}) : super(key: key);

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
        leading: backButton(context),
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: Column(
        children: [
          rDescription == null
              ? Container()
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Report Description : ',
                        style: Styles.buttonTextBlackBold,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        rDescription,
                        style: Styles.buttonTextBlack,
                        maxLines: 10,
                      ),
                      Divider(
                        color: Color.fromRGBO(140, 143, 165, 1),
                      ),
                    ],
                  ),
                ),
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
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => PhotoViewer('https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1200px-Image_created_with_a_mobile_phone.png')),
                      // );
                      Navigator.of(context).pushNamed(photoViewer,
                          arguments: PhotoViewer(
                              reportList[index]["file_path"], true));
                      // showDialog(
                      //     context: context,
                      //     builder: (context) => reportViewer(
                      //         docPath: reportList[index]["file_path"]));
                    },
                    child: Container(
                      child: Image.network(
                        'https://www.alodoctor-care.com/app-backend/public${reportList[index]["file_path"]}',
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
