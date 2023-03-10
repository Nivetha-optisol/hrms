import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


import 'dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<LoginPage> {
  var itemm ;
  var first_name ;
  var last_name ;
  var user_name ;
  var email ;
  var companyid ;
  var departmentid ;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late bool newuser ;

  @override
  void initState() {
    super.initState();
    checkLogin();


  }

  void checkLogin () async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? val = await pref.getString("LOGIN");
    if(val != null){
      Navigator.of(context).pushAndRemoveUntil(
       MaterialPageRoute(builder: (context) => Dashboard()) ,
      (route) => false);
    }

  }




  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            padding: EdgeInsets.only(
                top: 100.0, right: 20.0, left: 20.0, bottom: 20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  Image(
                      image: AssetImage('assets/logo.png')
                  ),
                  SizedBox(height: 40.0,),
                  Text(
                    "LOGIN",
                    style: TextStyle(
                        fontSize: 37.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo
                    ),
                  ),
                  SizedBox(height: 60.0,),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        labelText: "Email",

                        border: OutlineInputBorder( borderRadius: BorderRadius.circular(25.0),),
                        suffixIcon: Icon(Icons.email)),


                  ),
                  SizedBox(height: 40.0,),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: "Password",

                        border: OutlineInputBorder(

                          borderRadius: BorderRadius.circular(25.0),

                        ),
                        suffixIcon: Icon(Icons.password)),

                  ),
                  SizedBox(height: 40.0,),
                  RaisedButton(
                    child: Text("Add New"),

                    onPressed: (){
                         submit();
                    },
                    textColor: Colors.indigo,
                    color: Colors.orange,
                    splashColor: Colors.indigo,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),


                  ),
                  SizedBox(height: 40.0,),





                ]
            )
        )
    );
  }

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();


  }


  Future<void> submit()async{


    if(passwordController.text.isNotEmpty && emailController.text.isNotEmpty){
     http.Response response =   await http.post(Uri.parse("https://www.pearlcons.com/hrms/pearlchrmsapi/emp/loginhrms.php"),body:({
        'username':emailController.text ,
        'password' : passwordController.text,


      }) );

      if(response.statusCode==200){
        var item =  json.decode(response.body)['error'];

        print( " item"+item);
        itemm =  json.decode(response.body)['Data']['id'];
         first_name = json.decode(response.body)['Data']['first_name'];
        last_name = json.decode(response.body)['Data']['last_name'];
         user_name = json.decode(response.body)['Data']['username'];
         email = json.decode(response.body)['Data']['email'];
         companyid = json.decode(response.body)['Data']['company_id'];
        departmentid = json.decode(response.body)['Data']['department_id'];



         print("fname" + first_name);
        print("Lname" + last_name);
        print("uname" + user_name);
        print("Email" + email);
        print("Company_id" + companyid);
        print("DeptId"  +  departmentid);

        print( " itemmmm"+itemm);
        if(item=="000"){
          SharedPreferences pref  = await SharedPreferences.getInstance();
          await pref.setString("LOGIN",item );
          SharedPreferences id  = await SharedPreferences.getInstance();
          await id.setString("Empid",itemm );
          SharedPreferences firstname  = await SharedPreferences.getInstance();
          await firstname.setString("FirstName",first_name );
          SharedPreferences lastname  = await SharedPreferences.getInstance();
          await lastname.setString("LastName",last_name );
          SharedPreferences username  = await SharedPreferences.getInstance();
          await username.setString("UserName",user_name );
          SharedPreferences Email  = await SharedPreferences.getInstance();
          await Email.setString("Email",email );
          SharedPreferences Companyid  = await SharedPreferences.getInstance();
          await Companyid.setString("Company_id",companyid );
          SharedPreferences Departmentid  = await SharedPreferences.getInstance();
          await Departmentid.setString("Department_id",departmentid );





          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Dashboard()) ,
                  (route) => false);

        }
        else{
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid Credentials")));

        }
        //

      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid Credentials")));
      }
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Blank Field Not Allowed")));

    }

  }

}





