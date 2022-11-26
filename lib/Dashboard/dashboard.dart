import 'package:flutter/material.dart';
import 'package:unnovate/Child_Doc/doc_nav.dart';
import 'gridDashboard.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);
  
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 65,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.asset(
                  'assets/logo/Logo_name.png',
                  height: 75,
                ),
                /*IconButton(
                  alignment: Alignment.topCenter,
                  icon: const Icon(Icons.notifications),
                  onPressed: () {},
                )*/
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          GridDashboard(),
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const DocNav()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Center(
                      child: Container(
                        height: 75,
                        decoration: BoxDecoration(
                            image: const DecorationImage(image: AssetImage('assets/dashboard/doc.png'),opacity: 0.4, ),
                            borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'Doctor\'s Appointment',
                      style: TextStyle(
                          fontSize: 20,
                        color: Colors.black45
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
