import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Details extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var url = ModalRoute.of(context).settings.arguments;

    launch(url,
    forceWebView: false,
    forceSafariVC: true,
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("A"),
    //   ),
    // );
  }
}
