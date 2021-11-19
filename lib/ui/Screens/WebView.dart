import 'dart:io';
import 'package:alo_doctor_doctor/utils/MyConstants.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:alo_doctor_doctor/utils/Colors.dart';
import 'package:alo_doctor_doctor/utils/styles.dart';

class WebViewLoad extends StatefulWidget {
  String title;
  String webLink;
  WebViewLoad(this.title, this.webLink);
  WebViewLoadUI createState() => WebViewLoadUI();
}

class WebViewLoadUI extends State<WebViewLoad> {
  bool isLoading = true;
  final _key = UniqueKey();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: backButton(context),
        title: Column(
          children: [
            Text(
              // widget.title,
              "",
              style: Styles.regularHeading,
            )
          ],
        ),
        backgroundColor: accentBlueLight,
      ),
      body: Stack(
        children: [
          WebView(
            key: _key,
            initialUrl: widget.webLink,
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (finish) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(),
        ],
      ),
    );
  }
}
