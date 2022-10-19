import 'package:flutter/material.dart';

class ChildProfile extends StatefulWidget{
  const ChildProfile({Key? key}) : super(key: key);

  @override
  State<ChildProfile> createState() => _ChildProfile();
}

class _ChildProfile extends State<ChildProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: const SingleChildScrollView(
          child: SafeArea(
            child: Center(
                child:  Text("Child's Profile")
            ),
          ),
        )
    );
  }
}