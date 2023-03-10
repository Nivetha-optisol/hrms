import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class aboutus extends StatefulWidget {
  const aboutus({Key? key}) : super(key: key);

  @override
  _aboutusState createState() => _aboutusState();
}

class _aboutusState extends State<aboutus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
         SafeArea(
           child: Container(
             child: WebView(
             initialUrl: "https://www.pearlcons.com/hrms/pearlchrmsapi/emp/Aboutus.php",
               javascriptMode: JavascriptMode.unrestricted,

             ),
           ),
         )


    );

         //





  }
}
