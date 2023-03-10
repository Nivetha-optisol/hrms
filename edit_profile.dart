
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class editprofile extends StatefulWidget {
  @override
  _editprofileState createState() => _editprofileState();
}

class _editprofileState extends State<editprofile> {

  final email = TextEditingController();
  final firstName = TextEditingController();
  final LastName = TextEditingController();
  final contact= TextEditingController();
  final id= TextEditingController();


  Map<String, String> fieldValues = {};
  setFieldValue(label, value) {
    fieldValues[label] = value;
  }

  PickedFile? _imageFile ;
  final ImagePicker _picker = ImagePicker() ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        child: Form(
          child: Column(
            children: [
              imageprofile(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: firstName,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'FirstName',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Field is required.';
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        fieldValues['FirstName'] = value!;
                      });
                    }),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: LastName,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'LastName',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Field is required.';
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        fieldValues['LastName'] = value!;
                      });
                    }),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: email,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'E-mail',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Field is required.';
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        fieldValues['E-mail'] = value!;
                      });
                    }),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: contact,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Contact',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Field is required.';
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        fieldValues['Contact'] = value!;
                      });
                    }),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: id,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Id"),
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Field is required.';
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        fieldValues["Id"] = value!;
                      });
                    }),
              ),
              Container(
                child: ElevatedButton(
                  onPressed: (){
                    submit();
                    
                  }, child: Text("Submit"),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

  imageprofile() {
    return Stack(
      children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage: _imageFile == null ? AssetImage('assets/man.png'):FileImage(File(_imageFile!.path)) as ImageProvider,
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context, builder: ((builder) => bottomSheet()));
            },
            child: Icon(
              Icons.camera_alt,
              color: Colors.indigo,
              size: 28.0,
            ),
          ),
        )
      ],
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile Photo ",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(
                  icon: Icon(Icons.camera),
                  onPressed: () {
                    takephoto(ImageSource.camera);
                  },
                  label: Text('Camera')),
              FlatButton.icon(
                  icon: Icon(Icons.image),
                  onPressed: () {
                    takephoto(ImageSource.gallery);
                  },
                  label: Text('Gallery'))
            ],
          )
        ],
      ),
    );
  }

  void takephoto(ImageSource source) async{
    final pickedFile = await _picker.getImage(
        source: source ,
    ) ;
    setState(() {
      _imageFile = pickedFile!;
      
    });
  }

  Future<void> submit()async{


    Map mapeddate  = {
      'id':  id.text ,
      'first_name': firstName.text ,
      'last_name': LastName.text,

      'email' :email.text ,
      'contact_no ':  contact.text ,
      'profile_photo' : firstName.text



    } ;
    print("JSON DATA :  ${mapeddate}") ;


    http.Response response = await http.post(Uri.parse("https://www.pearlcons.com/hrms/pearlchrmsapi/emp/profileedit.php"),body: mapeddate) ;
    var data = jsonDecode(response.body);
    print("DATA: ${data}");



  }


}
