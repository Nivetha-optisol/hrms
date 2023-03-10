import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class history extends StatefulWidget {
  const history({Key? key}) : super(key: key);

  @override
  _historyState createState() => _historyState();
}

class _historyState extends State<history> {
  String empid = "";
  List users = [];
  @override
  void initState() {
    super.initState();
    getCred();

  }

  void getCred() async{

    SharedPreferences id = await SharedPreferences.getInstance();
    setState(() {

      empid = id.getString("Empid")!;
      print("empid"+empid);
      fetchUser();


    });

  }
  fetchUser() async {
    Map mapResponse = {'employee_id': empid};
    var url = "https://www.pearlcons.com/hrms/pearlchrmsapi/emp/attendancehistory.php";
    var response = await http.post(Uri.parse(url), body: mapResponse);
    if (response.statusCode == 200) {
      var items = json.decode(response.body)['Data'];
      setState(() {
        users = items;
      });
    } else {
      setState(() {
        users = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: <Widget>[
                  Container(
                    child: getBody(),
                  )
                ],
              )
            ],
          )
      ),
    );
  }

  Widget getCard(index) {
    var id = index['id'];
    var employee_id = index['employee_id'];
    var date = index['attendance_date'];
    var clockin = index['clock_in'];
    var clock_in_ip = index['clock_in_ip'];
    var clockout = index['clock_out'];
    var clockout_ip = index['clock_out_ip'];
    var clock_in_out = index['clock_in_out'];
    var time_late = index['time_late'];
    var early_leaving = index['early_leaving'] ;
    var overtime = index['overtime'];
    var totalwork = index['total_work'];
    var total_rest = index['total_rest'];
    var attendancestatus = index['attendance_status'];
    var workfromhome = index['workfromhome'] ;
    return SingleChildScrollView(
      child: Card(
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
                      "ID :" + " " + " " + id.toString(),
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ) ,
                    Text(
                      "EMPLOYEE-ID :" + " " + " " + employee_id.toString(),
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ) ,
                    Text(
                      "ATTENDANCE-DATE :" + " " + " " + date.toString(),
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ) ,
                    Text(
                      "CLOCK-IN :" + " " + " " + clockin.toString(),
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    )  ,
                    Text(
                      "CLOCK-IN-IP :" + " " + " " + clock_in_ip.toString(),
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ) ,

                    Text(
                      "CLOCK-OUT :" + " " + " " + clockout.toString(),
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ) ,
                    Text(
                      "CLOCK-OUT-IP :" + " " + " " + clockout_ip.toString(),
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ) ,
                    Text(
                      "CLOCK-IN-OUT :" + " " + " " + clock_in_out.toString(),
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ) ,
                    Text(
                      "TIME LATE :" + " " + " " + time_late.toString(),
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    )  ,
                    Text(
                      "EARLY-LEAVING :" + " " + " " + early_leaving.toString(),
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ) ,
                    Text(
                      "OVERTIME :" + " " + " " + overtime.toString(),
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ) ,
                    Text(
                      "TOTAL-WORK :" + " " + " " +totalwork.toString(),
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ) ,
                    Text(
                      "TOTAL REST :" + " " + " " + total_rest.toString(),
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ) ,
                    Text(
                      "ATTENDANCE STATUS :" + " " + " " + attendancestatus.toString(),
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    )  ,
                    Text(
                      "WORK-FROM-HOME:" + " " + " " + workfromhome.toString(),
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    )

                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  getBody() {
    return ListView.builder(
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: users.length,
        itemBuilder: (context, index) {
          return getCard(users[index]);
        });
  }
}
