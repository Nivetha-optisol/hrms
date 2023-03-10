import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
class pdf5 extends StatefulWidget {
  const pdf5({Key? key}) : super(key: key);

  @override
  _pdf5State createState() => _pdf5State();
}

class _pdf5State extends State<pdf5> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SfPdfViewer.asset('assets/may.pdf')
        )
    );
  }
}
