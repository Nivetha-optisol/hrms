import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hrms_proj/milestone.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

  class TaskPage extends StatefulWidget {
    const TaskPage({Key? key}) : super(key: key);

    @override
    _TaskPageState createState() => _TaskPageState();
  }

  class _TaskPageState extends State<TaskPage> {
 String empid ="";

    List users = [];


    @override
    void initState() {
      super.initState();
      getcred();

    }

    void getcred() async{
      SharedPreferences id = await SharedPreferences.getInstance();
      setState(() {

        empid = id.getString("Empid")!;
        print("empid"+empid);
        fetchUser();


      });
    }

    fetchUser() async {
      Map mapResponse =
      {
        'id': 1.toString(),
        'project_id' :  10.toString()

      };
      var url = "https://www.pearlcons.com/hrms/pearlchrmsapi/emp/taskview.php";
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

        backgroundColor: Colors.white,
        extendBody: true,


        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Column(
                    children:<Widget> [
                      Container(
                        child: getBody(),
                      )

                    ],

                  )

                ],
              )
            ],
          ),
        ),
      );
    }

    Widget getCard(index) {
      var Taskname = index['task_name'];
      var Taskstatus = index['task_status'];


      return GestureDetector(
        onTap: (){
          Navigator.push(
              context, MaterialPageRoute(builder: (context) =>milestone()
          ));
        }
        ,
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
                        "TASK NAME :" + " " + " " + Taskname.toString(),
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                         Text(
                        "TASK STATUS : " + " " + " " + Taskstatus.toString(),
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                       /* Text(
                        "TASK PROGRESS :" + " " + " " + Taskprogress.toString(),
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.green,
                            fontWeight: FontWeight.bold),
                      ),     */
                      SizedBox(
                        height: 10,
                      ),

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
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: users.length,
          itemBuilder: (context, index) {
            return getCard(users[index]);
          });
    }
  }




