import 'package:flutter/material.dart';
import 'package:hrms_proj/loginpage.dart';
import 'package:flutter/services.dart' ;
import 'package:shared_preferences/shared_preferences.dart';

import 'aboutus.dart';
import 'contactus.dart';

class Maindrawer extends StatefulWidget {
  const Maindrawer({Key? key}) : super(key: key);

  @override
  _MaindrawerState createState() => _MaindrawerState();
}

class _MaindrawerState extends State<Maindrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Colors.white,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,

                    margin: EdgeInsets.only(
                      top: 30 ,
                      bottom: 10
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle ,
                      image: DecorationImage(
                        image:NetworkImage(
                          'https://www.pearlcons.com/wp-content/uploads/2020/12/aaaa_preview_rev_1_006e006e0_4280.png'
                        ) ,
                        fit: BoxFit.fill


                      )

                    ),

                  )   ,
                     Text(
                       'PEARLCON TECHNOLOGIES' , style: TextStyle(
                       fontSize: 22 ,
                       fontWeight: FontWeight.bold,
                       color: Colors.indigo ,
                     ),
                     ) ,

                  Text(
                    'Innovative Solutions! Incremental Values !' , style: TextStyle(

                    color: Colors.deepOrange ,
                  ),
                  )

                ]
              ),
            ),
          ) ,

          ListTile(
            leading: Icon(Icons.people , color: Colors.deepOrange,),
            title: Text(
              "About Us" ,
              style: TextStyle(
                fontSize: 18 ,
                color: Colors.indigo
              ),
            ),
            onTap: (){
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => aboutus()
              ));
            },

          ) ,
          ListTile(
            leading: Icon(Icons.call, color: Colors.deepOrange,),
            title: Text(
              "Contact Us" ,
              style: TextStyle(
                  fontSize: 18 ,
                  color: Colors.indigo
              ),
            ),
            onTap: (){
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => contactus()
              ));
            },

          ) ,

          ListTile(

            leading: Icon(Icons.logout , color: Colors.deepOrange,),

            title: Text(
              "Logout" ,
              style: TextStyle(
                  fontSize: 18 ,
                  color: Colors.indigo
              ),
            ),
            onTap: () async{
              SharedPreferences pref  = await SharedPreferences.getInstance() ;
              await pref.clear() ;
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginPage()) ,
                      (route) => false);
            },

          )
        ],
      ),
    );
  }
}
