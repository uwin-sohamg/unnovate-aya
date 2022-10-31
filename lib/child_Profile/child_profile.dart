import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unnovate/child_Profile/user_dialog.dart';
import 'child.dart';

class ChildProfile extends StatefulWidget{
  const ChildProfile({Key? key}) : super(key: key);

  @override
  State<ChildProfile> createState() => _ChildProfile();
}


class _ChildProfile extends State<ChildProfile> {

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

    void showKidDialog(){
      showDialog(context: context, builder: (_){
        return AlertDialog(
          content: AddChildData(addKidData),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
        );
      });
    }
    
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: showKidDialog,
        child: const Icon(Icons.add),
      ),
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: Column(
            children: [
            const SizedBox(height: 50,),
            Center(
              child: Text(
                'Parent\'s Details',
                style: GoogleFonts.bebasNeue(
                  fontSize: 52,
                  color: Colors.black45
                ),
                ),
              ),

              const SizedBox(height: 20,),
            Card(
              margin: const EdgeInsets.all(4),
              elevation: 8,
              child: Container(
                child: const ListTile(
                  title: Text('Shalin Shah',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text('Email: shalin@gmail.com',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  trailing: Text(
                    'xxxxxxxxxx',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              )
            ),
              const SizedBox(height: 50,),

              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete),
                    iconSize: 24.0,
                    color: Colors.red,
                    onPressed: (){

                    },
                  ),
                  Card(
                    margin: const EdgeInsets.all(4),
                    child: Column(
                      children: [
                        const SizedBox(height: 20,),
                        Text(
                          'Child\'s Details',
                          style: GoogleFonts.bebasNeue(   //setting up welcome text on login page.
                            fontSize: 52,
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.75,
                          child: ListView.builder(itemBuilder: (ctx,index){
                            return Card(
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
                                trailing: Text(
                                  kidList[index].gender,
                                  style: const TextStyle(
                                    fontSize: 18,
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
                ],
              ),
            ],
          ),
        )
    );
  }
}