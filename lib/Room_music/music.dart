import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unnovate/child_Profile/child_profile.dart';
import 'package:unnovate/Child_Diet/child_diet.dart';


//creating list of items to be displayed on dashboard and items to appear on each tab.
class Music extends StatelessWidget {
  final Items item1 = Items(
      title: "Baby Rhythms",
      img: 'assets/music/rhthym.png'
  );
  final Items item2 = Items(
      title: "Sleep Music",
      img: 'assets/music/sleep.png'
  );
  Music({super.key});


  //listing out navigation from each tab.
  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2];

    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: const EdgeInsets.only(left: 110, right: 110),                  //original 16,16
          crossAxisCount: 1,                                                    //original 2
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return GestureDetector(
              onTap: () {
                if(data.title=="Baby Rhythms"){
                  Navigator.of(context).pushNamed("/webview");
                }
                else if(data.title=="Sleep Music"){
                  Navigator.of(context).pushNamed("/webview");
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(data.img),opacity: 0.4, fit: BoxFit.cover),
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
                                fontSize: 16,
                                fontWeight: FontWeight.w600)),
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
