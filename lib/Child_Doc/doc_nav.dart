import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unnovate/Child_Doc/child_doc.dart';
import 'package:unnovate/child_Profile/child.dart';

class DocNav extends StatefulWidget{
  const DocNav({Key? key}) : super(key: key);

  @override
  State<DocNav> createState() => _DocNav();
}


class _DocNav extends State<DocNav> {

  void getCharactersfromApi() async {
    CharacterApi.getCharacters().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        if (kDebugMode) {
          print(response.body);
        }
        kidList = list.map((model) => User.fromJson(model)).toList();
      });
    });
  }

  @override
  void initState(){
    getCharactersfromApi();
    super.initState();
  }

  List<User> kidList = [];

  @override
  Widget build(BuildContext context) {

    void addKidData(User kid){
      setState(() {
        kidList.add(kid);
      });
    }

    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 70,),

              Card(
                margin: const EdgeInsets.all(4),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const SizedBox(height: 20,),
                      Text(
                        'Select Child to Book Appointment',
                        style: GoogleFonts.bebasNeue(   //setting up welcome text on login page.
                          fontSize: 30,
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.75,
                        child: ListView.builder(itemBuilder: (ctx,index){
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ChildDoc(id: kidList[index].id)),
                              );
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: Colors.blueGrey,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              margin: const EdgeInsets.all(4),
                              elevation: 8,
                              child: ListTile(
                                title: Text(
                                  kidList[index].kidname.toString(),
                                  style: const TextStyle(
                                    fontSize: 22,
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text('Date of Birth: ${kidList[index].age}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                trailing: Column(
                                  children: [
                                    Text(kidList[index].id.toString(),
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(height: 10,),
                                    Text(
                                      kidList[index].gender,
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                          itemCount: kidList.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}