import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
//import 'package:unnovate/child_Profile/child_profile.dart';
import 'package:unnovate/Dashboard/dashboard.dart';

class UpdateChildData extends StatefulWidget{

  const UpdateChildData({super.key, required this.id});
  final int id;

  @override
  _UpdateChildDataState createState() => _UpdateChildDataState(id);
}

class _UpdateChildDataState extends State<UpdateChildData> {

  int id1=0;
  _UpdateChildDataState(id) {
    id1 = id;
  }

  var kidController = TextEditingController();
  var ageController = TextEditingController();
  var genderController;

  @override
  Widget build(BuildContext context) {

    createData(id2) async {
      Map data = {
        "id":id2,
        "doctor_Name":"Gillery",
        "gender":genderController,
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

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
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

            Column(
              children: [
                const SizedBox(height: 10),
                const Text('Select gender of child:'),
                RadioListTile(
                  title: const Text("Male"),
                  value: "male",
                  groupValue: genderController,
                  onChanged: (value){
                    setState(() {
                      genderController = value.toString();
                    });
                  },
                ),

                RadioListTile(
                  title: const Text("Female"),
                  value: "female",
                  groupValue: genderController,
                  onChanged: (value){
                    setState(() {
                      genderController = value.toString();
                    });
                  },
                ),

                RadioListTile(
                  title: const Text("Other"),
                  value: "other",
                  groupValue: genderController,
                  onChanged: (value){
                    setState(() {
                      genderController = value.toString();
                    });
                  },
                )
              ],
            ),

            ElevatedButton(

                onPressed: (){
                  createData(id1);
                  _showToast();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Dashboard()));
                },
                child: const Text('Add Child')
            )
          ],
        ),
      ),
    );
  }

  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text("Child Data Updated Successfully."),
        ],
      ),
    );


    //setting up toast message location.
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }
}