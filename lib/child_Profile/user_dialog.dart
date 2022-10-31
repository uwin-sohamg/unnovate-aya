import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:unnovate/Dashboard/dashboard.dart';
import 'package:unnovate/child_Profile/child.dart';
import 'dart:math';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:unnovate/child_Profile/child_profile.dart';

class AddChildData extends StatefulWidget{

  final Function(User) addKid;
  const AddChildData(this.addKid, {super.key});

  @override
  _AddChildDataState createState() => _AddChildDataState();
}

class _AddChildDataState extends State<AddChildData> {

  int id1 = Random().nextInt(100);
  var kidController = TextEditingController();
  var ageController = TextEditingController();
  var genderController;

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
                  final kid= User(kidController.text, ageController.text,
                  genderController);
                  sendChildData();
                  widget.addKid(kid);
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

  sendChildData() async {

    Map data = {
      "id":id1,
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
          Text("New Child Added Successfully."),
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
