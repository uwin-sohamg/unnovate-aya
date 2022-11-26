import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;


class RoomLock extends StatefulWidget{
  const RoomLock({Key? key}) : super(key: key);

  @override
  State<RoomLock> createState() => _RoomLock();
}

class _RoomLock extends State<RoomLock> {

  var lockController = TextEditingController();
  bool subButton= false;

  sendLockData() async {

    var data = lockController.text;
    var body = json.encode(data);
    var response = await http.post(Uri.parse("https://aya-uwindsor.herokuapp.com/dooraccess/authenticate"),
        headers: {"Content-Type": "application/json"},
        body: body
    );

    if(response.body.toString() == 'Access Granted'){
      _showGranted();
    }
    else{
      _showNotGranted();
    }

    if (kDebugMode) {
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {

    Widget buildTextField(String hint, TextEditingController controller){

      return Container(
        margin: const EdgeInsets.all(4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: TextField(
                obscureText: true,
                keyboardType: TextInputType.number,
                decoration: (
                    const InputDecoration
                      (
                        border: InputBorder.none,
                        hintText: 'Password',                               //setting up input section for user password input.
                      )
                    ),
                controller: lockController,
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(                              //returning scaffold for basic framework development.
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 35),

                  Image.asset(
                    'assets/logo/logo.png',         //setting app logo on login page.
                    height: 190,
                  ),

                  const SizedBox(height: 75),

                  Text(
                    'Door Lock',
                    style: GoogleFonts.bebasNeue(   //setting up welcome text on login page.
                      fontSize: 52,
                    ),
                  ),

                  const SizedBox(height: 10,),

                  const Text(
                    'Enter password to unlock the door',
                    style: TextStyle(
                        fontSize: 20
                    ),
                  ),
                  const SizedBox(height: 50,),

                  buildTextField('Password', lockController),

                  const SizedBox(height: 20,),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        disabledForegroundColor: Colors.blue.withOpacity(0.38), disabledBackgroundColor: Colors.blue.withOpacity(0.12)
                      ),
                    onPressed: subButton
                        ? (){
                            sendLockData();
                            setState(() {
                              subButton = false;
                              lockController.clear();
                            });
                          } : null,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(right: 120, left: 120, top: 20, bottom: 20),
                        child: Text(
                          'Unlock',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25,),

                ],),
            ),
          ),
        )
    );
  }


  //setting up initial state.
  late FToast fToast;

  @override
  void initState() {
    if (kDebugMode) {
      print(lockController.text);
    }
    lockController.addListener(() {
      final subButton = lockController.text.isNotEmpty;
      setState(() {
        this.subButton = subButton;
      });
    });
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  //toast pop-up to show message to the user.
  _showGranted() {
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
          Text("Unlocked"),
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

  _showNotGranted() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.redAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.cancel),
          SizedBox(
            width: 12.0,
          ),
          Text("Access Denied"),
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
