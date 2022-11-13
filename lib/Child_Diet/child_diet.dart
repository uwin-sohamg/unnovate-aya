import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChildDiet extends StatefulWidget {
  const ChildDiet({Key? key}) : super(key: key);

  @override
  State<ChildDiet> createState() => _ChildDiet();
}

List<String> nutrientsName = ['Protein', 'Calorie', 'Food', 'Dairy'];

class _ChildDiet extends State<ChildDiet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: Container(
            padding: EdgeInsets.all(5),
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
                    "Danish",
                    style: GoogleFonts.bebasNeue(
                        color: const Color(0xFF607C8B),
                        fontSize: 30,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "AGE: 2",
                    style: GoogleFonts.bebasNeue(
                        color: const Color(0xFF607C8B),
                        fontSize: 30,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "MALE",
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
              GestureDetector(
                child: Card_Nutrients("Protein"),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text(
                              'Food high in Protein',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.bebasNeue(
                                  color: const Color(0xFF607C8B),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                            ),
                            content: Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
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
                child: Card_Nutrients("Carbohydrates"),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text(
                              'Food high Carbohydrates',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.bebasNeue(
                                  color: const Color(0xFF607C8B),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                            ),
                            content: Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
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
                child: Card_Nutrients("Vitamins"),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text(
                              'Food high in Vitamins',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.bebasNeue(
                                  color: const Color(0xFF607C8B),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                            ),
                            content: Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
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
                child: Card_Nutrients("Fats"),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text(
                              'Food high in Fats',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.bebasNeue(
                                  color: const Color(0xFF607C8B),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                            ),
                            content: Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.bebasNeue(
                                  color: const Color(0xFF94B0C0),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                            ),
                          ));
                },
              )
            ]),
          )),
        ));
  }

  Widget Card_Nutrients(String nutrients_Type) {
    return Card(
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
        child: Text(
          nutrients_Type,
          style: GoogleFonts.bebasNeue(
              color: const Color(0xFF607C8B),
              fontSize: 30,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
