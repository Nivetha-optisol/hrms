import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
class pdf1 extends StatefulWidget {
  const pdf1({Key? key}) : super(key: key);

  @override
  _pdf1State createState() => _pdf1State();
}

class _pdf1State extends State<pdf1> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: SfPdfViewer.asset('assets/jan.pdf')
        )
    );
  }
}
