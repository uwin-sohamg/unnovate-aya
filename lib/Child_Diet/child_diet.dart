import 'package:flutter/material.dart';

class ChildDiet extends StatefulWidget{
  const ChildDiet({Key? key}) : super(key: key);

  @override
  State<ChildDiet> createState() => _ChildDiet();
}

class _ChildDiet extends State<ChildDiet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: const SingleChildScrollView(
          child: SafeArea(
            child: Center(
                child:  Text("Child's Diet")
            ),
          ),
        )
    );
  }
}