import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:unnovate/Dashboard/dashboard.dart';
import 'package:unnovate/child_Profile/update_child.dart';

class DelChildData extends StatefulWidget{

  const DelChildData({super.key, required this.id, required this.n, required this.d, required this.g});
  final int id;
  final String n;
  final String d;
  final String g;

  @override
  _DelChildDataState createState() => _DelChildDataState(id, n, d, g);
}

class _DelChildDataState extends State<DelChildData> {
  int id1=0;
  String n1 ='';
  String d1 ='';
  String g1 ='';
  _DelChildDataState(id, n, d, g) {
     id1 = id;
     n1 = n;
     d1 = d;
     g1 = g;
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

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 250,),
                  const Text('Modify Child\'s Data',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      color: Colors.blueGrey,
                    ),
                  ),
                  const SizedBox(height: 30,),
                  ElevatedButton(
                    onPressed: () {
                      delData(id1);
                      _showToast();
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Dashboard()));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.only(top: 35, bottom: 35, left: 45, right: 45),
                      backgroundColor: const Color(0xFF673AB7),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    child: Text(
                      'Delete Child\'s data',
                      style: GoogleFonts.bebasNeue(fontWeight: FontWeight.w400, fontSize: 15),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UpdateChildData(id: id1, n: n1, d: d1, g: g1,)),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.only(top: 35, bottom: 35, left: 45, right: 45),
                      backgroundColor: const Color(0xFF673AB7),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    child: Text(
                      'Update Child\'s Data',
                      style:
                      GoogleFonts.bebasNeue(fontWeight: FontWeight.w400),
                    ),
                  ),

                ],
              )),
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