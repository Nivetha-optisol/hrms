import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class contactus extends StatefulWidget {
  const contactus({Key? key}) : super(key: key);

  @override
  _contactusState createState() => _contactusState();
}

class _contactusState extends State<contactus> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebView(
        initialUrl: "https://www.pearlcons.com/hrms/pearlchrmsapi/emp/contactus.php",
        javascriptMode: JavascriptMode.unrestricted,

      ),
    );
  }
}
