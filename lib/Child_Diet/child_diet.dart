import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unnovate/Child_Diet/diet.dart';

class ChildDiet extends StatefulWidget {
  const ChildDiet({super.key, required this.id, required this.nam, required this.dob, required this.gen});
  final int id;
  final String dob;
  final String gen;
  final String nam;

  @override
  State<ChildDiet> createState() => _ChildDiet(id, dob, gen, nam);
}

List<String> nutrientsName = ['Calories', 'Protein', 'Food', 'Dairy'];

class _ChildDiet extends State<ChildDiet> with TickerProviderStateMixin{

  int id1=0;
  DateTime d= DateTime.now();
  String d1='';
  DateTime now = DateTime.now();
  String nam1='';
  String g= '';
  var chmonth;
  var cmonth;
  String suf='';
  int d2=0;
  bool b= false;
  bool a = true;

  _ChildDiet(id, dob, gen, nam) {
    id1 = id;
    d1= dob;
    d= DateTime.parse(dob);
    cmonth = now.difference(d).inDays;
    d2= cmonth as int;
    if(d2>30 && d2<365){
      cmonth= now.difference(d).inDays/30;
      suf='Months';
    }
    else if(d2>=365){
      cmonth= now.difference(d).inDays/365;
      suf='Years';
      a=false;
    }
    else{
      cmonth= now.difference(d).inDays;
      suf='Days';
    }
    chmonth = cmonth.floor();
    g= gen;
    nam1= nam;
  }

  getdiet() async {
    Map data = {
      "gender": g,
      "dob": d1
    };
    var body = json.encode(data);
    var response = await http.post(Uri.parse("https://aya-uwindsor.herokuapp.com/childnutrition/fetchDetails"),
        headers: {"Content-Type": "application/json"},
        body: body
    );
    if (kDebugMode) {
      print(response.body);
    }
    setState(() {
      Iterable list = json.decode(response.body);
      if (kDebugMode) {
        print(response.body);
      }
      D_List = list.map((model) => Diet.fromJson(model)).toList();
      b=true;
      dispose();
    });
  }

  List<Diet> D_List = [];
  late AnimationController controller;


  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
      setState(() {});
    });
    controller.repeat(reverse: false);
    getdiet();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: Container(
            padding: const EdgeInsets.all(5),
            // margin: EdgeInsets.all(),
            child: Image.asset(
              "assets/logo/Logo_name.png",
              height: 90,
              width: 90,
            ),
          ),
          centerTitle: true,
          // actions: [Container(
          //
          //   margin: EdgeInsets.all(10),
          //   child: Image.asset("assets/logo/Logo_name.png"),)],
        ),
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: SafeArea(
              child: Center(
            child: Column(children: [
              const SizedBox(
                height: 23,
              ),
              Text(
                "Essential Nutrients",
                style: GoogleFonts.bebasNeue(
                    color: const Color(0xFF607C8B),
                    fontSize: 35,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    nam1,
                    style: GoogleFonts.bebasNeue(
                        color: const Color(0xFF607C8B),
                        fontSize: 30,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'AGE: ${chmonth.toString()} $suf',
                    style: GoogleFonts.bebasNeue(
                        color: const Color(0xFF607C8B),
                        fontSize: 30,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    g,
                    style: GoogleFonts.bebasNeue(
                        color: const Color(0xFF607C8B),
                        fontSize: 30,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              const SizedBox(
                height: 23,
              ),
              a ? Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  AlertDialog(
                    title: Text(
                      'Child is below 1 year',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.bebasNeue(
                          color: const Color(0xFF607C8B),
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                    content: Text(
                      "Breastfeeding is recommended",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.bebasNeue(
                          color: const Color(0xFF94B0C0),
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ):
              b==false ? CircularProgressIndicator(
                value: controller.value,
                semanticsLabel: 'Circular progress indicator',
              )
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Card(
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.cyan
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Total calories intake\nneeded by baby:",
                                style: TextStyle(
                                    fontSize: 20
                                ),
                              ),
                              Text(
                                D_List[0].calories,
                                style: const TextStyle(
                                    fontSize: 20
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 23,
                  ),
                  const Text(
                    "Tap on below items for their source:",
                    style: TextStyle(
                        fontSize: 20
                    ),
                  ),
                  const SizedBox(
                    height: 23,
                  ),
                  GestureDetector(
                    child: Card_Nutrients("Proteins", D_List[0].protein.toString()),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              'Food high Proteins',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.bebasNeue(
                                  color: const Color(0xFF607C8B),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                            ),
                            content: Text(
                              "Choose seafood, lean meat and poultry, eggs, beans, peas, soy products, and unsalted nuts and seeds.",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.bebasNeue(
                                  color: const Color(0xFF94B0C0),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                            ),
                          ));
                    },
                  ),
                  GestureDetector(
                    child: Card_Nutrients("Dairy", D_List[0].dairy.toString()),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              'Food high in Dairy Suppliments',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.bebasNeue(
                                  color: const Color(0xFF607C8B),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                            ),
                            content: Text(
                              "Encourage your child to eat and drink fat-free or low-fat dairy products, such as milk, yogurt and cheese. Fortified soy beverages also count as dairy.",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.bebasNeue(
                                  color: const Color(0xFF94B0C0),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                            ),
                          ));
                    },
                  ),
                  GestureDetector(
                    child: Card_Nutrients("Other Food", D_List[0].food.toString()),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              'Fruits, Vegetables and Grains:',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.bebasNeue(
                                  color: const Color(0xFF607C8B),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                            ),
                            content: Text(
                              "Fruits. Encourage your child to eat a variety of fresh, canned, frozen or dried fruits. Look for canned fruit that says it's light or packed in its own juice. This means it's low in added sugar. Keep in mind that 1/4 cup of dried fruit counts as one serving of fruit. \n\nVegetables. Serve a variety of fresh, canned, frozen or dried vegetables. Choose peas or beans, along with colorful vegetables each week. When selecting canned or frozen vegetables, look for ones that are lower in sodium. \n\nGrains. Choose whole grains, such as whole-wheat bread or pasta, oatmeal, popcorn, quinoa, or brown or wild rice.",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.bebasNeue(
                                  color: const Color(0xFF94B0C0),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                            ),
                          )
                      );
                    },
                  )
                ],
              )
            ]),
          )),
        ));
  }

  Widget Card_Nutrients(String nutrientsType, String intk) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        shadowColor: Colors.black,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFFD9DCF1),
          ),
          padding: const EdgeInsets.only(left: 17),
          alignment: Alignment.centerLeft,
          height: 60,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  nutrientsType,
                  style: GoogleFonts.bebasNeue(
                      color: const Color(0xFF607C8B),
                      fontSize: 30,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  intk,
                  style: GoogleFonts.bebasNeue(
                      color: const Color(0xFF607C8B),
                      fontSize: 30,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
