import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Calendar.dart';
import 'HomePage.dart';
import 'Maindrawer.dart';
import 'PaySlip.dart';
import 'ProfilePage.dart';
import 'TaskPage.dart';
class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int index = 0 ;
  String token= "" ;
  String empid= "" ;
  final  screens = [
    HomePage(),
    TaskPage(),
    PaySlip(),
    Calendar(),
    ProfilePage(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCred ();
  }

  void getCred() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    SharedPreferences id = await SharedPreferences.getInstance();
    setState(() {
      token = pref.getString("LOGIN")!;
      empid = id.getString("Empid")!;
      print("empid"+empid);


    });

  }
  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Icons.home,size: 30),
      Icon(Icons.push_pin_rounded,size: 30),
      Icon(Icons.payments,size: 30),
      Icon(Icons.calendar_today_sharp,size: 30),
      Icon(Icons.people_alt_outlined,size: 30,),



    ];
    return Scaffold(
       extendBody: true,
      appBar: AppBar(
        title: Text('HRMS'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color(0xFFFB415B),
                  Color(0xFFEE5623)
                ],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft
            ),
          ),
        ),

      ),
      endDrawer: Maindrawer(),
      body: screens[index],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: IconThemeData(color:Colors.black54 ),

      ),
      child : CurvedNavigationBar(
          height: 45,
          buttonBackgroundColor: Colors.redAccent,
          backgroundColor: Colors.transparent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 250),
          index: index,
          items: items ,
          onTap: (index) => setState(()  => this.index = index),





        ),



),
    );
  }
}
