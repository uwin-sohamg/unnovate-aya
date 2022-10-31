import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'login.dart';
//import 'package:http/http.dart' as http;

//Making a stateful widget and calling state through it.
class SignUp extends StatefulWidget{
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUp();
}

//sign-up state.
class _SignUp extends State<SignUp>{

  /*sendSignupData() async {
      var response = http.post(Uri.parse("https://aya-uwindsor.herokuapp.com/ex/foos/post"));
  }*/

  @override
  Widget build(BuildContext context){
    return Scaffold(                                                            //returning scaffold for basic framework development.
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(                                            //to prevent pixel render
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 25),

                  Image.asset(
                    'assets/logo/logo.png',                                     //setting app logo on sign-up page.
                    height: 190,
                  ),

                  const SizedBox(height: 50),

                  Text(
                    'Enter Your Details',
                    style: GoogleFonts.bebasNeue(                               //Input fields for user data.
                      fontSize: 52,
                    ),
                  ),

                  const SizedBox(height: 10,),

                  const Text(
                    'Best solution for baby care',
                    style: TextStyle(
                        fontSize: 20
                    ),
                  ),
                  const SizedBox(height: 35,),

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
                            hintText: 'Parent\'s Name',
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
                          decoration: (InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email',
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
                          decoration: (InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Phone Number',
                          )),
                          keyboardType: TextInputType.number,
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
                            hintText: 'Password',
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
                            hintText: 'Confirm Password',
                          )),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child:   Container(
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextButton(
                        onPressed: () {
                          _toastmsg();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Login()),
                          ); },
                        child:  Container(
                          padding: const EdgeInsets.all(15),
                          child: const Center(
                            child:  Text(
                              'Sign Up',
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
  _toastmsg() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          SizedBox(
            width: 12.0,
          ),
          Text("Sign Up Successful."),
        ],
      ),
    );


    //setting up toast message location.
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 1),
    );
  }
}