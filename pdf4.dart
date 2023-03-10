import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
class pdf4 extends StatefulWidget {
  const pdf4({Key? key}) : super(key: key);

  @override
  _pdf4State createState() => _pdf4State();
}

class _pdf4State extends State<pdf4> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SfPdfViewer.asset('assets/apr.pdf')
        )
    );
  }
}
