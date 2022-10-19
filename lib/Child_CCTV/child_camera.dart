import 'package:flutter/material.dart';

class CCTV extends StatefulWidget{
  const CCTV({Key? key}) : super(key: key);

  @override
  State<CCTV> createState() => _CCTV();
}

class _CCTV extends State<CCTV> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: const SingleChildScrollView(
          child: SafeArea(
            child: Center(
                child:  Text("Camera")
            ),
          ),
        )
    );
  }
}