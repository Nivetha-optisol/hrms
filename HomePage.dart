import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'ApplyLeave.dart';
import 'Ticket.dart';
import 'history.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>

{

   String empid = "" ;
   String name = "" ;
   var login ;


  List users = [];
 String  now = DateFormat("yyyy-MM-dd").format(DateTime.now());

  String current = DateFormat("HH:mm").format(DateTime.now());
  TextEditingController clockin = TextEditingController();


 late Color newColor ;
 @override
  void initState() {
    // TODO: implement initState
   getlocation();
   checklogin();
    super.initState();

   getCred();


  }





  fetchUser() async {
    Map mapResponse = {'employee_id':  empid};
    var url = "https://www.pearlcons.com/hrms/pearlchrmsapi/emp/announcements.php";
    var response = await http.post(Uri.parse(url), body: mapResponse);
    if (response.statusCode == 200) {
      var items = json.decode(response.body)['Data'];
      setState(() {
        users = items;
        print(items);
      });
    } else {
      setState(() {
        users = [];
      });
    }
  }
  var long = "";
  var lat = "";
    bool isVisibleA=false;
    bool isVisibleB=false;

  void getlocation() async {
    LocationPermission per = await Geolocator.checkPermission();
    if (per == LocationPermission.denied ||
        per == LocationPermission.deniedForever) {
      LocationPermission per1 = await Geolocator.requestPermission();
    } else {
      Position currentLoc = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      setState(() {
        long = currentLoc.longitude.toString();
        lat = currentLoc.latitude.toString();

      });
    }
  }
   void getCred() async{

     SharedPreferences id = await SharedPreferences.getInstance();
     setState(() {

       empid = id.getString("Empid")!;
       print("empid"+empid);
  fetchUser();
  fname();
  checklogin();

     });

   }
   void fname() async{

     SharedPreferences username = await SharedPreferences.getInstance();
     setState(() {
       name = username.getString("UserName")!;
       print("Name"+ name);





     });

   }




  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Container(

              child: Column(
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          "assets/man.png",
                          width: 150.0,
                        ),
                        Text(""),
                        Text(""),
                        Text(""),
                        Text(
                         name,
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange),
                        )
                      ]),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                          Text(
                            "  ",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo),
                          ),


                          Visibility(
                            visible: isVisibleA,
                            child: ElevatedButton(onPressed: () async {

                              Position currentLoc = await Geolocator.getCurrentPosition(
                                  desiredAccuracy: LocationAccuracy.bestForNavigation);
                              setState(() {
                                print(login);

                                long = currentLoc.longitude.toString();
                                lat = currentLoc.latitude.toString();
                                double longitude=double.parse(long);
                                double latitude=double.parse(lat);
                                var lats=latitude.toStringAsFixed(1) ;
                                var longs=longitude.toStringAsFixed(1);
                                print("longitude"+longs+"latitude"+lats);

                                if(longs=="80.2" && lats=="13.0")
                                {
                                  print('your are in office');
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) => _buildPopupDialog(context),
                                  );
                                }
                                else{
                                  print('your not are in office');
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) => _buildPopupDialognotinoffice(context),
                                  );
                                }
                                // checklogin();


                              });


                            },
                              child: Text("CLOCK-IN"    ),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.purple,
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  textStyle:
                                  TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                            ),
                          ) ,
                        Visibility(
                          visible: isVisibleB,
                          child: ElevatedButton(onPressed: () async {

                            Position currentLoc = await Geolocator.getCurrentPosition(
                                desiredAccuracy: LocationAccuracy.bestForNavigation);
                            setState(() {
                              //isVisibleA = true ;
                             // isVisibleB= false ;


                              long = currentLoc.longitude.toString();
                              lat = currentLoc.latitude.toString();
                              double longitude=double.parse(long);
                              double latitude=double.parse(lat);
                              var lats=latitude.toStringAsFixed(1) ;
                              var longs=longitude.toStringAsFixed(1);
                              print("longitude"+longs+"latitude"+lats);
                              if(longs=="80.2" && lats=="13.0")
                              {

                                print('your are in office Kindly Check Out');
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) => _buildPopupDialogcheckout(context),
                                );
                              }
                              else{
                                print('your not are in office');
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) => _buildPopupDialognotinofficecheckout(context),
                                );
                              }
                              // checklogin();

                            });



                          },

                              child: Text("CLOCK-OUT"),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.purple,
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                textStyle:
                                TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                          ),
                        )



                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Divider(
                    height: 2.0,
                    color: Colors.blue,
                    thickness: 3, // thickness of the line
                    indent: 20, // empty space to the leading edge of divider.
                    endIndent:
                        20, // empty space to the trailing edge of the divider.
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "ANNOUNCEMENT",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      Container(

                          height: MediaQuery.of(context).size.height * 0.10,
                        child:  ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: users.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: Card(
                                  color: Colors.white70,
                                  child: Container(
                                    child: Center(
                                        child: Text(
                                          users[index]['description'].toString(),
                                          style: TextStyle(
                                              color: Colors.black, fontSize: 15.0),
                                        )),
                                  ),
                                ),
                              );
                            }),

                      )


                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.5),
                    child: Center(
                      child: Wrap(
                        spacing: 10.0,
                        runSpacing: 10.0,
                        children: [

                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => counselling()
                              ));
                            },
                            child: SizedBox(
                              width: 160.0,
                              height: 160.0,


                              child: Card(
                                color: Colors.greenAccent,
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "assets/ticket.png",
                                          width: 80.0,
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          "TICKETS",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                             GestureDetector(
                               onTap: (){
                                 Navigator.push(
                                     context, MaterialPageRoute(builder: (context) => ApplyLeave()
                                 ));
                               },
                            child: SizedBox(
                              width: 160.0,
                              height: 160.0,
                              child: Card(
                                color: Colors.orangeAccent,
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "assets/absent.png",
                                          width: 80.0,
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          "APPLY LEAVE",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => history()
                              ));
                            },
                            child: SizedBox(
                              width: 160.0,
                              height: 160.0,
                              child: Card(
                                color: Colors.orangeAccent,
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "assets/absent.png",
                                          width: 80.0,
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          "ATTENDANCE HISTORY",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),



                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('Popup example'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("You are in Office So  Please check In Now "),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
        new FlatButton(
          onPressed: () {
            Navigator.pop(context);
            clockIn();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("CLOCKED-IN SUCESSFULLY")));
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Check in'),
        ),
      ],
    );
  }
  Widget _buildPopupDialognotinoffice(BuildContext context) {
    return new AlertDialog(
      title: const Text('Popup  example'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("You are in workfrom home mode "),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.pop(context);

          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
        new FlatButton(
          onPressed: () {
            Navigator.pop(context);
               home();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Check-in'),

        ),

      ],
    );
  }
  Widget _buildPopupDialogcheckout(BuildContext context) {
    return AlertDialog(
      title: const Text('INFO'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("You are in Office So  Please check Out Now "),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
        new FlatButton(
          onPressed: () {
            Navigator.pop(context);
            clockOut();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("CLOCKED-OUT")));
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Check Out'),

        ),
      ],
    );
  }
  Widget _buildPopupDialognotinofficecheckout(BuildContext context) {
    return new AlertDialog(
      title: const Text('INFO'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("You are not in office so you can't check in  "),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),

      ],
    );
  }

  void clockIn() async {
    print('Date'+ 'now '+ current) ;



 Map mapeddata = {
   'employee_id': empid,
   'clock_in' : current ,
   'attendance_date' : now


    };
    print(mapeddata);


    http.Response response = await http.post(Uri.parse("https://www.pearlcons.com/hrms/pearlchrmsapi/emp/checkin.php"),body: mapeddata) ;
    var data = jsonDecode(response.body);
    print("DATA: ${data}");




  }


  void clockOut() async {


    var clockedout;
    Map mapeddata = {
      'employee_id':  empid,
      'clock_out' : current

    };


    http.Response response = await http.post(Uri.parse("https://www.pearlcons.com/hrms/pearlchrmsapi/emp/checkout.php"),body: mapeddata) ;
    var data = jsonDecode(response.body);
    print("DATA: ${data}");




  }

  void home() async{
    Map mapeddata = {
      'employee_id':  empid,
      'clock_in' : current ,
      'attendance_date' : now,
      'work_from_home' : current


    };
    print(mapeddata);
    http.Response response = await http.post(Uri.parse("https://www.pearlcons.com/hrms/pearlchrmsapi/emp/checkin.php"),body: mapeddata) ;
    var data = jsonDecode(response.body);
    print("DATA: ${data}");



  }

 /* getbody() {

      return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: users.length,
          itemBuilder: (context, index) {
            return getCard(users[index]);
          });
    }    */


   /* Widget getCard(index) {
      var announcement = index['description'];

      return Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListTile(

            title: Row(
              children: <Widget>[
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Start Date :" + " " + " " + startDate.toString(),
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "End Date : " + " " + " " + endDate.toString(),
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Status :" + " " + " " + status.toString(),
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.green,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Leave Type :" + " " + " " + leaveType.toString(),
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.pink,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }   */


   checklogin() async {
     print("emplogincheck" + empid);
     print("attendancecheck" + now);

     Map mapResponse = {
       'employee_id':  empid ,
       'attendance_date':now

     };
     var url = "https://www.pearlcons.com/hrms/pearlchrmsapi/emp/checklogin.php";
     var response = await http.post(Uri.parse(url), body: mapResponse);
     if (response.statusCode == 200) {
       var ite = json.decode(response.body)['message'];
        print(now);
       setState(() {
          login = ite;
         print('login'+login);
         if(login=='0'){
           isVisibleB = false ;
           isVisibleA = true ;

         }
         else if(login=='1'){
           isVisibleB = true ;
           isVisibleA = false ;
         }
         print(isVisibleA);
          print(isVisibleB);
       });
     }

   }


}
