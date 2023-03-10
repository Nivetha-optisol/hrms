import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class milestone extends StatefulWidget {
  const milestone({Key? key}) : super(key: key);

  @override
  _milestoneState createState() => _milestoneState();
}

class _milestoneState extends State<milestone> {
  //DateTimeRange dateRange =
   //   DateTimeRange(start: DateTime(2022, 11, 5), end: DateTime(2022, 12, 24));
  double _currentSliderValue = 20;
  String dropdownValue = '';
  Map<String, String> fieldValues = {};
  @override
  Widget build(BuildContext context) {
    //final start = dateRange.start;
   // final end = dateRange.end;
  //  final difference = dateRange.duration ;

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
        padding: const EdgeInsets.all(5),
        child: Container(
          child: Column(
            children: <Widget>[
              Text(
                "ESTIMATED DATE",
                style: TextStyle(
                    fontSize: 15.00,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(

              ) ,
              SizedBox(
                height: 30,
              ),









           Text('PROGRESS'
                 ,style: TextStyle(
                 fontSize: 18.00,
                 fontWeight: FontWeight.bold,
                 color: Colors.indigo

             ),) ,

          Slider
            (

            activeColor: Colors.red, // The color to use for the portion of the slider track that is active.
            inactiveColor: Colors.red[100], // The color for the inactive portion of the slider track.
            thumbColor: Colors.red,
            value: _currentSliderValue,
            max: 100,
            divisions: 4,
            label: _currentSliderValue.round().toString(),
            onChanged: (double value) {
              setState(() {
                _currentSliderValue = value;
              });
            },
          ) ,


              Container(
                child: DropdownButtonFormField(
                    value: dropdownValue,
                    items: const [
                      DropdownMenuItem<String>(
                          child: Text('STATUS'), value: ''),
                      DropdownMenuItem<String>(child: Text('Ongoing'), value: 'Ongoing'),
                      DropdownMenuItem<String>(
                          child: Text('NotStarted'), value: 'NotStarted'),
                      DropdownMenuItem<String>(
                          child: Text('Pending'), value: 'Pending'),

                      DropdownMenuItem<String>(child: Text('Completed'), value: 'Completed'),


                    ],
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    validator: (value) {
                      if (dropdownValue == '')
                        return 'You must select any one of the field.';
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        fieldValues['Drop Down'] = value.toString();
                      });
                    }),

              ),
              SizedBox(
                height: 150.0,
              ) ,
              ElevatedButton(onPressed: (){
                print("dates") ;
              }, child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
              )




            ],
          ),
        ),
      ),
    );
  }



}
