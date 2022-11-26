import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:unnovate/Dashboard/dashboard.dart';
import 'package:intl/intl.dart';

class UpdateChildData extends StatefulWidget{

  const UpdateChildData({super.key, required this.id, required this.n, required this.d, required this.g});
  final int id;
  final String n;
  final String d;
  final String g;

  @override
  _UpdateChildDataState createState() => _UpdateChildDataState(id, n, d, g);
}

class _UpdateChildDataState extends State<UpdateChildData> {

  int id1=0;
  String g1= '';
  _UpdateChildDataState(id, n, d, g) {
    id1 = id;
    kidController.text = n;
    ageController.text = d;
    g1 = g;
  }

  var kidController = TextEditingController();
  var ageController = TextEditingController();
  String genderController = '';
  bool b1= true;
  bool b2= true;
  bool b3= true;

  @override
  Widget build(BuildContext context) {

    createData(id2) async {
      Map data = {
        "id":id2,
        "name":kidController.text,
        "gender":genderController,
        "dob":ageController.text,
        "docid" : "1"
      };
      var body = json.encode(data);
      var response = await http.post(Uri.parse("https://aya-uwindsor.herokuapp.com/kidsprofile/update/"),
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
            const SizedBox(height: 70,),
            const Text('Add Child\'s Data',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                color: Colors.blueGrey,
              ),
            ),

            const SizedBox(height: 15,),
            buildTextField('Child\'s Name', kidController),

          Container(
              padding: const EdgeInsets.all(15),
              height: MediaQuery.of(context).size.width / 3,
              child: Center(
                  child: TextField(
                    controller: ageController,
                    //editing controller of this TextField
                    decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_today), //icon of text field
                        labelText: "Enter Date" //label text of field
                    ),
                    readOnly: true,
                    //set it true, so that user will not able to edit text
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2100));

                      if (pickedDate != null) {
                        if (kDebugMode) {
                          print(
                            pickedDate);
                        } //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                        if (kDebugMode) {
                          print(
                            formattedDate);
                        } //formatted date output using intl package =>  2021-03-16
                        setState(() {
                          ageController.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {}
                    },
                  ))),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text('Male', style: TextStyle(
                        fontSize: 10
                    ),),
                    leading: Radio(
                      value: 'male',
                      onChanged: (value) {
                        setState(() {
                          genderController = value.toString();
                          b3 = true;
                        });
                      }, groupValue: genderController,
                    ),
                  ),
                ),

                Expanded(
                  child: ListTile(
                    title: const Text('Female',  style: TextStyle(
                        fontSize: 10)),
                    leading: Radio(
                      value: 'female',
                      onChanged: (value) {
                        setState(() {
                          genderController = value.toString();
                          b3 = true;
                        });
                      }, groupValue: genderController,
                    ),
                  ),
                ),
              ],
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  disabledForegroundColor: Colors.blue.withOpacity(0.38), disabledBackgroundColor: Colors.blue.withOpacity(0.12)
              ),
              onPressed: b1 && b2 && b3
                  ? (){
                createData(id1);
                _showToast();
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Dashboard()));
              } : null,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Text(
                  'Update Child',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),

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
    kidController.addListener(() {
      final b1 = kidController.text.isNotEmpty;
      setState(() {
        this.b1 = b1;
      });
    });
    ageController.addListener(() {
      final b2 = ageController.text.isNotEmpty;
      setState(() {
        this.b2 = b2;
      });
    });
    print(g1);
    setState(() {
      genderController = g1;
    });
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