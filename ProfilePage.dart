import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'edit_profile.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

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
    Map mapResponse = {'id': empid


    };
    var url = "https://www.pearlcons.com/hrms/pearlchrmsapi/emp/profile.php";
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
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: <Widget>[
              Image.asset(
                "assets/man.png",
                width: 150.0,
              ),

              Container(
                child:  getBody() ,

              )  ,
              Container(
                child: ElevatedButton.icon(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.deepOrange,
                    size: 24.0,
                  ),
                  label: Text('EDIT'),
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) =>editprofile()
                    ));
                  },
                  style: ElevatedButton.styleFrom(

                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0),

                    ),
                  ),
                )
                ),

            ],
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
        itemCount:  users.length,
        itemBuilder: (context, index) {

          return getCard(users[index]) ;
        });

  }
  Widget getCard(index) {
    var firstname = index['first_name'];
    var lastname = index['last_name'];
    var email = index['email'];
    var contact = index['contact_no'];
    var gender = index['gender'];
    var martialstatus = index['marital_status'];




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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "FIRST NAME :" + " " + " " + firstname .toString(),
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Container(
                    child: Text(
                      "LAST NAME :" + " " + " " + lastname.toString(),
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w500),
                    ),
                  ) ,
                  SizedBox(
                    height: 35,
                  ),
                  Container(
                    child: Text(
                      "EMAIL :" + " " + " " + email.toString(),
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w500),
                    ),
                  ) ,
                  SizedBox(
                    height: 35,
                  ),
                  Container(
                    child: Text(
                      "CONTACT :" + " " + " " + contact.toString(),
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w500),
                    ),
                  ) ,

                  SizedBox(
                    height: 35,
                  ),
                  Container(
                    child: Text(
                      "GENDER :" + " " + " " + gender.toString(),
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w500),
                    ),
                  ) ,

                  SizedBox(
                    height: 35,
                  ),
                  Container(
                    child: Text(
                      "MARTIAL STATUS  :" + " " + " " + martialstatus.toString(),
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w500),
                    ),
                  ) ,







                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}
