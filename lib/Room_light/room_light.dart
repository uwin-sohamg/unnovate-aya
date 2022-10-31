import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class RoomLight extends StatefulWidget{
  const RoomLight({Key? key}) : super(key: key);

  @override
  State<RoomLight> createState() => _RoomLight();
}

class _RoomLight extends State<RoomLight> {


  changeOFF() async {
    var lightStatus= '0';
    if (kDebugMode) {
      print(lightStatus);
    }

    var body = json.encode(lightStatus);
    var response = await http.post(Uri.parse("https://aya-uwindsor.herokuapp.com/lightstatus/changeLightStatus"),
        headers: {"Content-Type": "application/json"},
        body: body
    );
    if (kDebugMode) {
      print(response.body);
    }
    _showToastOFF();
  }

  changeON() async {
    var lightStatus= '1';
    if (kDebugMode) {
      print(lightStatus);
    }

    var body = json.encode(lightStatus);
    var response = await http.post(Uri.parse("https://aya-uwindsor.herokuapp.com/lightstatus/changeLightStatus"),
        headers: {"Content-Type": "application/json"},
        body: body
    );
    if (kDebugMode) {
      print(response.body);
    }
    _showToastON();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: (){
                              changeON();
                            },
                            child: const Text('ON'),
                        ),
                        ElevatedButton(
                          onPressed: (){
                            changeOFF();
                          },
                          child: const Text('OFF'),
                        )
                      ],
                    ),
                  ],
                )
            ),
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

  //toast pop-up to show message to the user.
  _showToastON() {
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
          Text("Light ON."),
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

  _showToastOFF() {
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
          Text("Light OFF."),
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