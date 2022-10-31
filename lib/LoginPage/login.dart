import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:unnovate/Dashboard/dashboard.dart';
import 'signup.dart';
import 'package:http/http.dart' as http;


//Making a stateful widget and calling state through it.
class Login extends StatefulWidget{
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _Login();
}


//login state.
class _Login extends State<Login>{
  
  sendSignupData() async {

    Map data = {"id": "123",
      "name": "Shalin"
    };
    var body = json.encode(data);
    var response = await http.post(Uri.parse("https://aya-uwindsor.herokuapp.com/ex/foos/"),
    headers: {"Content-Type": "application/json"},
    body: body
    );

    if (kDebugMode) {
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context){
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
                    'Hello Again',
                    style: GoogleFonts.bebasNeue(   //setting up welcome text on login page.
                      fontSize: 52,
                    ),
                  ),

                  const SizedBox(height: 10,),

                  const Text(
                    'Welcome Back, you\'ve been missed',
                    style: TextStyle(
                        fontSize: 20
                    ),
                  ),
                  const SizedBox(height: 50,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: TextField(
                          decoration: (InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email',                                  //setting up input section for user email input.
                          )),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: TextField(
                          obscureText: true,
                          decoration: (InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Password',                               //setting up input section for user password input.
                          )),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15,),

                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child:   Container(
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextButton(
                            onPressed: () {
                              //sendSignupData();
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const Dashboard()),
                              ); },
                            child:  Container(
                              padding: const EdgeInsets.all(15),
                              child: const Center(
                                child:  Text(
                                  'Sign In',                                    //making button to login to the dashboard.
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                        ),
                      ),
                  ),

                  const SizedBox(height: 25,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('New User?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUp()));},
                        child: const Text(' Register Now',                      //making navigation, to direct user to signup page.
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 25,),

                  TextButton(
                    onPressed: () {
                      _showToast();
                    },
                    child: const Text(' Forgot Password',                       //directs user to password recovery.
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
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
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  //toast pop-up to show message to the user.
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
          Text("Email sent to your registered email ID."),
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