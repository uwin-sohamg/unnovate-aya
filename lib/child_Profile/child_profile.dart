import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unnovate/Dashboard/dashboard.dart';
import 'package:unnovate/child_Profile/parent.dart';
import 'package:unnovate/child_Profile/child.dart';
import 'package:unnovate/child_Profile/user_dialog.dart';
import 'package:http/http.dart' as http;
import 'delchild.dart';

class ChildProfile extends StatefulWidget{


  const ChildProfile({super.key});

  @override
  State<ChildProfile> createState() => _ChildProfile();

}


class _ChildProfile extends State<ChildProfile> {

  var P_name = TextEditingController();
  var P_mail = TextEditingController();
  var P_mob = TextEditingController();
  late final Function(Parent) addKid;
  var P_nam= 'Loading Parent\'s Details...';
  var em= '';
  var mn= '';


  Widget buildTextField(String hint, TextEditingController controller){
    return Container(
      margin: const EdgeInsets.all(4),
      child: TextField(
        decoration: InputDecoration(
            labelText: hint,
            border: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black38,
                )
            )
        ),
        controller: controller,
      ),
    );
  }


  void getPCharactersfromApi() async {
    PCharacterApi.getPCharacters().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        if (kDebugMode) {
          print(response.body);
        }
        P_List = list.map((model) => Parent.fromJson(model)).toList();
        P_nam= P_List[0].parentsname.toString();
        mn= 'Mob: ${P_List[0].mobileno.toString()}';
        em= 'Email: ${P_List[0].emailid.toString()}';
      });
    });
  }


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
    if(kidList.isEmpty){
      const AlertDialog(
        content: Text("No child data available.."),
      );
      if (kDebugMode) {
        print("Empty");
      }
      getCharactersfromApi();
    }
    if(P_List.isEmpty){
      const AlertDialog(
        content: Text("No child data available.."),
      );
      if (kDebugMode) {
        print("Empty");
      }
      getPCharactersfromApi();
    }

    super.initState();
  }

  List<User> kidList = [];
  List<Parent> P_List = [];

  @override
  Widget build(BuildContext context) {

    void addKidData(User kid){
      setState(() {
        kidList.add(kid);
      });
    }

    void addParentData(Parent kid){
      setState(() {
        P_List.add(kid);
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
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            children: [
            const SizedBox(height: 70,),

            Card(
              margin: const EdgeInsets.all(4),
              elevation: 8,
              child: Column(
                children: [
                  const SizedBox(height: 10,),
                  Center(
                    child: Text(
                      'Parent\'s Details',
                      style: GoogleFonts.bebasNeue(
                          fontSize: 52,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10,),

                  GestureDetector(
                    onTap: (){
                      P_name.text = P_List[0].parentsname;
                      P_mail.text = P_List[0].emailid;
                      P_mob.text = P_List[0].mobileno;
                      showDialog(
                          context: context,
                          builder: (context) => Container(
                            padding: const EdgeInsets.all(0),
                            height: 450,
                            width: 700,
                            child: SingleChildScrollView(
                              child: Container(
                                padding: const EdgeInsets.only(top: 150),
                                child: AlertDialog(
                                  title: Text(
                                    'Edit Details',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.bebasNeue(
                                        color: const Color(0xFF607C8B),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  content: Column(
                                    children: [
                                      buildTextField('Parent\'s Name', P_name),
                                      const SizedBox(height: 15,),
                                      buildTextField('Parent\'s email', P_mail),
                                      const SizedBox(height: 15,),
                                      buildTextField('Parent\'s Phone Number', P_mob),
                                      const SizedBox(height: 15,),
                                      ElevatedButton(
                                          onPressed: (){
                                            sendParentData();
                                            fToast = FToast();
                                            fToast.init(context);
                                            _showPToast();
                                            Navigator.of(context).popUntil((route) => route.isFirst);
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Dashboard()));
                                          },
                                          child: const Text('Update Details')
                                      )
                                    ],
                                  )
                                ),
                              ),
                            ),
                          ));
                    },
                    child: ListTile(
                      title: Text(
                        P_nam,
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        em,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            mn,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          const Icon(Icons.edit),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ),
              const SizedBox(height: 25,),

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
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DelChildData(id: kidList[index].id, n: kidList[index].kidname, d: kidList[index].age, g: kidList[index].gender,)),
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
            ],
          ),
        )
    );
  }

  sendParentData() async {

    Map data = {
      "parentsname":P_name.text,
      "emailid":P_mail.text,
      "mobileno":P_mob.text,
      "id":1
    };
    var body = json.encode(data);
    var response = await http.post(Uri.parse("https://aya-uwindsor.herokuapp.com/parentdetails/update"),
        headers: {"Content-Type": "application/json"},
        body: body
    );

    if (kDebugMode) {
      print(response.body);
    }
  }

  late FToast fToast;

  _showPToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text("Parent's Details Updated."),
        ],
      ),
    );


    //setting up toast message location.
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }
}


