import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
class pdf2 extends StatefulWidget {
  const pdf2({Key? key}) : super(key: key);

  @override
  _pdf2State createState() => _pdf2State();
}

class _pdf2State extends State<pdf2> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SfPdfViewer.asset('assets/feb.pdf')
        )
    );
  }
}
