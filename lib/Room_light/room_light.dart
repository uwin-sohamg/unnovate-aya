import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class RoomLight extends StatefulWidget {
  const RoomLight({Key? key}) : super(key: key);

  @override
  State<RoomLight> createState() => _RoomLight();
}

class _RoomLight extends State<RoomLight> {
  changeON() async {
    var lightStatus = '0';
    if (kDebugMode) {
      print(lightStatus);
    }

    var body = json.encode(lightStatus);
    var response = await http.post(
        Uri.parse(
            "https://aya-uwindsor.herokuapp.com/lightstatus/changeLightStatus"),
        headers: {"Content-Type": "application/json"},
        body: body);
    if (kDebugMode) {
      print(response.body);
    }
    _showToastON();
    getLightStatus();
  }

  changeOFF() async {
    var lightStatus = '1';
    if (kDebugMode) {
      print(lightStatus);
    }

    var body = json.encode(lightStatus);
    var response = await http.post(
        Uri.parse(
            "https://aya-uwindsor.herokuapp.com/lightstatus/changeLightStatus"),
        headers: {"Content-Type": "application/json"},
        body: body);
    if (kDebugMode) {
      print(response.body);
    }
    _showToastOFF();
    getLightStatus();
  }

  var txt= '';

  getLightStatus() async {
    var response = await http.get(Uri.parse("https://aya-uwindsor.herokuapp.com/lightstatus/currentLightStatus"),
        headers: {"Content-Type": "application/json"},
    );
    if (kDebugMode) {
      print(response.body);
    }
    if (response.body.toString() == "1") {
      setState(() => txt= "Current Light Status:- OFF");
    }
    else{
      setState(() => txt= "Current Light Status:- ON");
    }
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 250,),
              Text(
                txt.toString(),
                style: GoogleFonts.bebasNeue(fontWeight: FontWeight.w400, fontSize: 35, color: Colors.black),
              ),
              const SizedBox(height: 30,),
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: txt == "Current Light Status:- OFF"
                          ? () {
                        changeON();
                      } : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(65),
                        backgroundColor: const Color(0xFF673AB7),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      child: Text(
                        'Light ON',
                        style: GoogleFonts.bebasNeue(fontWeight: FontWeight.w400, fontSize: 15),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: txt == "Current Light Status:- ON"
                        ? () {
                        changeOFF();
                      } : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(65),
                        backgroundColor: const Color(0xFF673AB7),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      child: Text(
                        'Light OFF',
                        style:
                        GoogleFonts.bebasNeue(fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
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
    getLightStatus();
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
