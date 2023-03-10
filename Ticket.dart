import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
class counselling extends StatefulWidget {


  @override
  _counsellingState createState() => _counsellingState();
}

class _counsellingState extends State<counselling> {
  String empid = "" ;
  List users = [];

  bool isLoading = false;


  @override
  void initState() {
    super.initState();

     cred();


  }

  cred() async{
    SharedPreferences id = await SharedPreferences.getInstance();
    setState(() {

      empid = id.getString("Empid")!;
      print("empid"+empid);
      fetchUser();


    });
  }

  fetchUser() async {
    Map mapResponse = {'employee_id': empid
    };
    var url = "https://www.pearlcons.com/hrms/pearlchrmsapi/emp/ticketview.php";
    var response = await http.post(Uri.parse(url), body: mapResponse);
    print(response);
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

  void getCred() async{

    SharedPreferences id = await SharedPreferences.getInstance();
    setState(() {

      empid = id.getString("Empid")!;
      print("empid"+empid);


    });

  }



  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String dropdownValue = '';
  var subject = TextEditingController();
  var description = TextEditingController() ;
  var priority = TextEditingController() ;

  Map<String, String> fieldValues = {};



  setFieldValue(label, value) {
    fieldValues[label] = value;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: SingleChildScrollView(

          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(

                      controller: subject,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'SUBJECT',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Field is required.';
                          return null;
                        },
                        ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      controller: description,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),

                          labelText: 'DESCRIPTION',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Field is required.';
                          return null;
                        },
                        ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(

                      controller: priority,

                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),

                        labelText: 'High/Low/Medium',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Field is required.';
                        return null;
                      },
                    ),
                  ),



                     SizedBox(height: 10.0,) ,

                  ElevatedButton(
                    onPressed: () {
                      submit() ;
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text("CONFIRMATION"),
                          content: Text("will solve shortly"),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                              child: Text("okay"),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Text('Submit'),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.purple,
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        textStyle:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                ],


        ),
              SizedBox(
                height :  10.0,
              ) ,
              SingleChildScrollView(
                child: Column(
                  children:<Widget> [
                    Container(

                      color: Colors.white10,
                      child: Padding(
                        padding: EdgeInsets.only( top: 10.0, right: 10.0, left: 10.0, bottom: 5.0),
                        child: Text("RECENT TICKETS "   ,  style:  TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo

                        ),),


                      ),

                    ) ,
                    SizedBox(
                      height: 10.0 ,
                    ) ,
                    Container(

                      child:  getBody() ,

                    ) ,


                  ],
                ),
              ),
            ],
          ),





      ),
      
    );
  }


  Future<void> submit()async{


    Map mapeddate  = {
      'subject':  subject.text ,
      'description': description.text ,
      'ticket_priority':priority.text


    } ;
    print("JSON DATA :  ${mapeddate}") ;


    http.Response response = await http.post(Uri.parse("https://www.pearlcons.com/hrms/pearlchrmsapi/emp/ticket.php"),body: mapeddate) ;
    var data = jsonDecode(response.body);
    print("DATA: ${data}");




  }

  getBody() {
    return ListView.builder(
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount:  users.length,
        itemBuilder: (context, index) {

          return getCard(users[index]) ;
        });
  }
  Widget getCard(index) {
    var subject = index['subject'];
    var priority = index['ticket_priority'];
    var status = index['ticket_status'];

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
                    "SUBJECT :" + " " + " " + subject.toString(),
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "TICKET PRIORITY : " + " " + " " + priority.toString(),
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "STATUS :" + " " + " " + status.toString(),
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  
                ],
              )
            ],
          ),
        ),
      ),
    );
  }





}
