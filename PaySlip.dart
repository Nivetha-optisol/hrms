import 'package:flutter/material.dart';
import 'package:hrms_proj/pdf1.dart';
import 'package:hrms_proj/pdf2.dart';
import 'package:hrms_proj/pdf3.dart';
import 'package:hrms_proj/pdf4.dart';
import 'package:hrms_proj/pdf5.dart';




class PaySlip extends StatefulWidget {
  @override
  _PaySlipState createState() => _PaySlipState();
}

class _PaySlipState extends State<PaySlip> {


  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => pdf1()));
          },
          child: Card(
              child: ListTile(
                  title: Text(
                    "PAYSLIP FOR THE MONTH OF JANUARY",
                    style: TextStyle(
                        color: Colors.indigo,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "  Pearlcon Technologies ",
                    style: TextStyle(color: Colors.red),
                  ),

              )
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => pdf2()));
          },
          child: Card(
              child: ListTile(
                title: Text(
                  "PAYSLIP FOR THE MONTH OF FEBRUARY",
                  style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "  Pearlcon Technologies ",
                  style: TextStyle(color: Colors.red),
                ),

              )
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => pdf3()));
          },
          child: Card(
              child: ListTile(
                title: Text(
                  "PAYSLIP FOR THE MONTH OF MARCH",
                  style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "  Pearlcon Technologies ",
                  style: TextStyle(color: Colors.red),
                ),

              )
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => pdf4()));
          },
          child: Card(
              child: ListTile(
                title: Text(
                  "PAYSLIP FOR THE MONTH OF APRIL",
                  style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "  Pearlcon Technologies ",
                  style: TextStyle(color: Colors.red),
                ),

              )
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => pdf5()));
          },
          child: Card(
              child: ListTile(
                title: Text(
                  "PAYSLIP FOR THE MONTH OF MAY",
                  style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "  Pearlcon Technologies ",
                  style: TextStyle(color: Colors.red),
                ),

              )
          ),
        ),

      ],
    );


  }
}
