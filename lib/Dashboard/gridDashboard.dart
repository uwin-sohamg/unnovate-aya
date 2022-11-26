import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unnovate/Child_Diet/diet_nav.dart';
import 'package:unnovate/child_Profile/child_profile.dart';
import 'package:unnovate/Room_light/room_light.dart';
import 'package:unnovate/Room_music/room_music.dart';
import 'package:unnovate/Child_lock/room_lock.dart';

import '../Child_Vaccine/vacc_nav.dart';


//creating list of items to be displayed on dashboard and items to appear on each tab.
class GridDashboard extends StatelessWidget {
  final Items item1 = Items(
      title: "Kid's Profile",
      img: 'assets/dashboard/baby.jpg'
  );
  final Items item2 = Items(
      title: "Kid's Diet",
      img: 'assets/dashboard/diet.jpg'
  );
  final Items item3 = Items(
    title: "Light Control",
    img: 'assets/dashboard/light.jpg'
  );
  final Items item4 = Items(
    title: "Music Control",
    img: 'assets/dashboard/speaker.jpg'
  );
  final Items item5 = Items(
    title: "Smart Lock",
    img: 'assets/dashboard/lock.jpeg'
  );
  final Items item6 = Items(
    title: "Kid's Vaccine",
    img: 'assets/dashboard/vaccine.jpeg'
  );

  GridDashboard({super.key});


  //listing out navigation from each tab.
  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4, item5, item6];

    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: const EdgeInsets.only(left: 16, right: 16),                  //original 16,16
          crossAxisCount: 2,                                                    //original 2
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return GestureDetector(
              onTap: () {
                  if(data.title=="Kid's Profile"){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ChildProfile()));
                  }
                  else if(data.title=="Kid's Diet"){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const DietNav()));
                  }
                  else if(data.title=="Light Control"){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const RoomLight()));
                  }
                  else if(data.title=="Music Control"){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const RoomMusic()));
                  }
                  else if(data.title=="Smart Lock"){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const RoomLock()));
                  }
                  else if(data.title=="Kid's Vaccine"){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const VacNav()));
                  }
              },
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(data.img), fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Text(
                        data.title,
                        style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 23,
                                fontWeight: FontWeight.bold
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList()),
    );
  }
}

//items to be taken in the list.
class Items {
  String title;
  String img;
  Items({required this.title, required this.img});
}
