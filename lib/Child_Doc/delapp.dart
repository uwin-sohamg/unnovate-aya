import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:unnovate/Dashboard/dashboard.dart';
import 'package:unnovate/child_Profile/update_child.dart';
//import 'package:unnovate/child_Profile/child_profile.dart';

class DelAppData extends StatefulWidget{

  const DelAppData({super.key, required this.id});
  final int id;

  @override
  _DelAppData createState() => _DelAppData(id);
}

class _DelAppData extends State<DelAppData> {
  int id1=0;
  _DelAppData(id) {
    id1 = id;
  }

  @override
  Widget build(BuildContext context) {


    delData(id2) async {
      Map data = {
        "id": id2,
      };
      var body = json.encode(data);
      var response = await http.post(Uri.parse("https://aya-uwindsor.herokuapp.com/kidsprofile/delete"),
          headers: {"Content-Type": "application/json"},
          body: body
      );

      if (kDebugMode) {
        print(response.body);
      }
    }


    return Container(
      padding: const EdgeInsets.all(8),
      height: 350,
      width: 400,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text('Delete Child\'s Data',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                color: Colors.blueGrey,
              ),
            ),

            const SizedBox(height: 15,),

            ElevatedButton(
                onPressed: (){
                  delData(id1);
                  _showToast();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Dashboard()));
                },
                child: const Text('Delete Child\'s data')
            ),

            ElevatedButton(

                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UpdateChildData(id: id1)),
                  );
                },
                child: const Text('Update Child\'s Data')
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
          Text("Child Deleted Successfully."),
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