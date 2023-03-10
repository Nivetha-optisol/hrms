import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
class pdf3 extends StatefulWidget {
  const pdf3({Key? key}) : super(key: key);

  @override
  _pdf3State createState() => _pdf3State();
}

class _pdf3State extends State<pdf3> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SfPdfViewer.asset('assets/mar.pdf')
        )
    );
  }
}
