import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:unnovate/child_Profile/child.dart';

class AddChildData extends StatefulWidget{

  final Function(User) addKid;
  const AddChildData(this.addKid, {super.key});

  @override
  _AddChildDataState createState() => _AddChildDataState();
}

class _AddChildDataState extends State<AddChildData> {

  int id=4;

  var kidController = TextEditingController();
  var ageController = TextEditingController();
  var genderController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    Widget buildTextField(String hint, TextEditingController controller){
      return Container(
        margin: const EdgeInsets.all(4),
        child: TextField(
          decoration: InputDecoration(
            labelText: hint,
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black38,
              )
            )
          ),
          controller: controller,
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(8),
      height: 350,
      width: 400,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text('Add Child\'s Data',
              style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32,
              color: Colors.blueGrey,
              ),
            ),

            const SizedBox(height: 15,),
            buildTextField('Child\'s Name', kidController),
            buildTextField('Age in dd/mm/yyyy', ageController,),
            buildTextField('Gender as male/female', genderController),

            ElevatedButton(
                onPressed: (){
                  final kid= User(kidController.text, ageController.text,
                  genderController.text);

                  sendChildData();
                  widget.addKid(kid);
                  Navigator.of(context).pop();
                },
                child: const Text('Add Child')
            )
          ],
        ),
      ),
    );
  }

  sendChildData() async {

    id=id+1;

    Map data = {
      "id":id,
      "doctor_Name":"Gillery",
      "gender":genderController.text,
      "doctor_Phone":"5698658877",
      "dob":ageController.text,
      "name":kidController.text
    };
    var body = json.encode(data);
    var response = await http.post(Uri.parse("https://aya-uwindsor.herokuapp.com/kidsprofile/create/"),
        headers: {"Content-Type": "application/json"},
        body: body
    );

    if (kDebugMode) {
      print(response.body);
    }
  }
}