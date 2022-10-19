import 'package:flutter/material.dart';

class RoomMusic extends StatefulWidget{
  const RoomMusic({Key? key}) : super(key: key);

  @override
  State<RoomMusic> createState() => _RoomMusic();
}

class _RoomMusic extends State<RoomMusic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: const SingleChildScrollView(
          child: SafeArea(
            child: Center(
                child:  Text("Room Music")
            ),
          ),
        )
    );
  }
}