import 'package:flutter/material.dart';

class RoomLight extends StatefulWidget{
  const RoomLight({Key? key}) : super(key: key);

  @override
  State<RoomLight> createState() => _RoomLight();
}

class _RoomLight extends State<RoomLight> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: const SingleChildScrollView(
          child: SafeArea(
            child: Center(
                child:  Text("Room Light")
            ),
          ),
        )
    );
  }
}