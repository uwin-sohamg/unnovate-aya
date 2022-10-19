import 'package:flutter/material.dart';

class RoomLock extends StatefulWidget{
  const RoomLock({Key? key}) : super(key: key);

  @override
  State<RoomLock> createState() => _RoomLock();
}

class _RoomLock extends State<RoomLock> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: const SingleChildScrollView(
          child: SafeArea(
            child: Center(
                child:  Text("Room Lock")
            ),
          ),
        )
    );
  }
}