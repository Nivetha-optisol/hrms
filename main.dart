// @dart=2.9
import 'package:flutter/material.dart';

import 'Dashboard.dart';
import 'loginpage.dart';

void main() => runApp(App());

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xFFFB415B),
          fontFamily: "Ubuntu"
      ),
      home: LoginPage(),
    );
  }
}

