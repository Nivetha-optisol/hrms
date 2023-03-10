import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:http/http.dart' as http;

class ApplyLeave extends StatefulWidget {
  @override
  _ApplyLeaveState createState() => _ApplyLeaveState();
}

class _ApplyLeaveState extends State<ApplyLeave> {

  List users = [];
  String empid = "" ;


  @override
  void initState() {
    super.initState();
    getCred();

  }
  late String startdates ;
  late String enddates ;


  void getCred() async{

    SharedPreferences id = await SharedPreferences.getInstance();
    setState(() {

      empid = id.getString("Empid")!;
      print("empid"+empid);
      fetchUser();


    });

  }

  fetchUser() async {
     print("employeeid"+empid);
    Map mapResponse = {'employee_id': empid};
    var url = "https://www.pearlcons.com/hrms/pearlchrmsapi/emp/leaveview.php";
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

  var reasonController = TextEditingController();

  final DateRangePickerController DateController = DateRangePickerController();

  var dates;

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
                  colors: [Color(0xFFFB415B), Color(0xFFEE5623)],
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 10.0, right: 100.0, left: 10.0, bottom: 5.0),
                      child: Text(
                        "REASON FOR APPLYING A LEAVE ", style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo

                      ),),
                    ),


                  ),
                  SizedBox(
                    height: (1.0),
                  ),
                  Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16),
                        child: TextFormField(
                          controller: reasonController,
                          minLines: 2,
                          maxLines: 5,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  20.0)),
                            ),

                          ),
                        ),

                      )
                  ),
                  Container(
                    child: Card(
                      margin: const EdgeInsets.fromLTRB(50, 10, 50, 1),
                      child: SfDateRangePicker(
                        view: DateRangePickerView.month,
                        initialSelectedDate: DateTime.now(),
                        selectionMode: DateRangePickerSelectionMode.range,
                        controller: DateController,
                        onSelectionChanged: selectionChanged,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    child: ElevatedButton(
                      onPressed: () {
                        submit();
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text("CONFIRMATION"),
                            content: Text("Submitted Sucessfully"),
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          textStyle:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                  ),


                ],
              ),
              SizedBox(
                  height: 50.0
              ),
              Column(
                children: <Widget>[
                  Container(

                    color: Colors.white10,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 10.0, right: 10.0, left: 10.0, bottom: 5.0),
                      child: Text("TOTAL LEAVES ", style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo

                      ),),


                    ),

                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  SingleChildScrollView(
                    child: Container(

                      child: getBody(),

                    ),
                  )
                ],
              ),
            ],
          ),
        )
    );
  }

  void selectionChanged(
      DateRangePickerSelectionChangedArgs dateRangePickerSelectionChangedArgs) {
    dates = dateRangePickerSelectionChangedArgs.value;
    PickerDateRange pickerDateRange = dateRangePickerSelectionChangedArgs.value;
    DateTime? startdate = pickerDateRange.startDate;
    startdates=DateFormat("yyyy-MM-dd").format(startdate!);

    DateTime? enddate= pickerDateRange.endDate;
    enddates=DateFormat("yyyy-MM-dd").format(enddate!);

    print("startdate"+startdates.toString() +""+"Enddate" +enddates.toString());

    final difference =daysBetween(startdate, enddate);
    print("check the days"+difference.toString());
  }
  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round()+1;
  }

  Widget getCard(index) {
    var startDate = index['start_date'];
    var endDate = index['start_date'];
    var status = index['status'];
    var leaveType = index['leave_type'];
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
  }

  getBody() {

    return users==null ? Center(
      child: CircularProgressIndicator(),
    ) :
      ListView.builder(
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: users.length,
        itemBuilder: (context, index) {
          return getCard(users[index]);
        });
  }

   submit() async {
    Map mapeddata = {
      'leave_type_id': 3.toString(),
      'start_date':  startdates      ,
      'leave_reason': enddates ,
      'company_id': 3.toString(),
      'department_id': 6.toString(),
      'employee_id': empid
    };
    print(mapeddata);
    var response = await http.post(Uri.parse(
        "https://www.pearlcons.com/hrms/pearlchrmsapi/emp/leavestatus.php"),
        body: mapeddata);
    var data = jsonDecode(response.body);
    print("DATA: ${data}");
  }
}







     //Map mapeddate  = {

      //'leave_reason':  reasonController.text ,
      //'start_date': dates,


    //} ;
    //print("JSON DATA :  ${mapeddate}") ;


    //http.Response response = await http.post(Uri.parse("https://www.pearlcons.com/hrms/pearlchrmsapi/emp/leavestatus.php"),body: mapeddate) ;
///    if(response.statusCode==200){
   //   print("JSON DATA :  ${mapeddate}") ;
 //   }





