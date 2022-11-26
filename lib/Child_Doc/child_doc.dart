import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:unnovate/Child_Doc/Doctor.dart';
import 'package:unnovate/Child_Doc/appointment.dart';
import 'package:unnovate/Child_Doc/update_app.dart';
import 'package:unnovate/Dashboard/dashboard.dart';

class ChildDoc extends StatefulWidget{
  const ChildDoc({super.key, required this.id});
  final int id;

  @override
  State<ChildDoc> createState() => _ChildDoc(id);
}

class _ChildDoc extends State<ChildDoc> {
  int id1=0;
  int id2=0;
  _ChildDoc(id) {
    id1 = id;
  }
  bool a = true;

  getvac() async {
    var response = await http.get(Uri.parse("https://aya-uwindsor.herokuapp.com/doctorList/read"),
    );

    if (kDebugMode) {
      print(response.body);
    }

    setState(() {
      Iterable list = json.decode(response.body);
      if (kDebugMode) {
        print(response.body);
      }
      Doc_List = list.map((model) => Doc.fromJson(model)).toList();
    });
    sepVac();
  }

  getapp() async {
    var response = await http.get(Uri.parse("https://aya-uwindsor.herokuapp.com/docAppointment/read"),
    );

    if (kDebugMode) {
      print(response.body);
    }

    setState(() {
      Iterable list = json.decode(response.body);
      if (kDebugMode) {
        print(response.body);
      }
      app = list.map((model) => Appointment.fromJson(model)).toList();
      for(int i=0; i< app.length; i++){
        if(app[i].childid == id1.toString()){
          app2.add(app[i]);
        }
      }
      if(app2.isEmpty){
          a=false;
          print(a);
      }
    });
  }


  sepVac(){
    int i=0;
    while(i!=Doc_List.length){
      if (kDebugMode) {
        print(i);
      }
      MissedVac.add(Doc_List[i].docname);
      _selectedD.add(false);
      i++;
    }
    getapp();
  }

  int? _selectedIndex=0;
  int? _selectIndex=1;
  final List<Vacc> vaccine = [
    const Vacc('  New\n  Appointments'),
    const Vacc('  Scheduled\n  Appointments'),
  ];

  bool b2= false;
  bool b1= false;

  @override
  void initState() {
    super.initState();
    getvac();
    dateController.addListener(() {
      final b2 = dateController.text.isNotEmpty;
      setState(() {
        this.b2 = b2;
      });
    });
  }


  TimeOfDay time = const TimeOfDay(hour: 12, minute: 30);

  var dateController = TextEditingController();

  List<Doc> Doc_List = [];
  List<Appointment> app = [];
  List<Appointment> app2 = [];
  List<String> MissedVac = [];
  List<bool> _selectedD = [];



  scheduleapp(int id3) async {

    Map data = {
      "childid":id1,
      "doctorid":id3,
      "date":dateController.text,
      "time" : time.format(context)
    };
    var body = json.encode(data);
    var response = await http.post(Uri.parse("https://aya-uwindsor.herokuapp.com/docAppointment/create"),
        headers: {"Content-Type": "application/json"},
        body: body
    );

    if (kDebugMode) {
      print(response.body);
    }
  }


  

  @override
  Widget build(BuildContext context) {

    final hours= time.hour.toString().padLeft(2, '0');
    final minutes= time.minute.toString().padLeft(2, '0');

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 70,),
                ExpansionPanelList(
                  expansionCallback: (i, b) {
                    if (_selectIndex == i){
                      _selectIndex = null;
                    }
                    else{
                      _selectIndex = i;
                      _selectedIndex = null;
                    }
                    setState(() {});
                  },
                  children: List.generate(
                    1,
                        (index) => ExpansionPanel(
                      canTapOnHeader: true,
                      isExpanded: index == _selectIndex,
                      headerBuilder: (context, isExpanded) {
                        return vaccine[0];
                      },
                      body: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                          Expanded(
                              child: Center(
                                  child: TextField(
                                    controller: dateController,
                                    //editing controller of this TextField
                                    decoration: const InputDecoration(
                                        icon: Icon(Icons.calendar_today), //icon of text field
                                        labelText: "dd/mm/yyyy" //label text of field
                                    ),
                                    readOnly: true,
                                    //set it true, so that user will not able to edit text
                                    onTap: () async {
                                      DateTime? pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1950),
                                          //DateTime.now() - not to allow to choose before today.
                                          lastDate: DateTime(2100));

                                      if (pickedDate != null) {
                                        if (kDebugMode) {
                                          print(
                                              pickedDate);
                                        } //pickedDate output format => 2021-03-10 00:00:00.000
                                        String formattedDate =
                                        DateFormat('yyyy-MM-dd').format(pickedDate);
                                        if (kDebugMode) {
                                          print(
                                              formattedDate);
                                        } //formatted date output using intl package =>  2021-03-16
                                        setState(() {
                                          dateController.text =
                                              formattedDate; //set output date to TextField value.
                                        });
                                      } else {}
                                    },
                                  )
                              )
                          ),

                              IconButton(onPressed: () async {
                                TimeOfDay? newTime = await showTimePicker(context: context, initialTime: time);
                                if(newTime==null) return;
                                setState(() => time= newTime);
                              }, icon: const Icon(Icons.timelapse)),

                              Expanded(
                                child: Text(
                                  time.format(context),
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            'Please select doctor from list:',
                            style: TextStyle(fontSize: 20),
                          ),
                          SingleChildScrollView(
                            child: Container(
                                  height: MediaQuery.of(context).size.height * 0.4,
                                  child: ListView.builder(itemBuilder: (ctx,index){
                                    return GestureDetector(
                                      onTap: (){
                                        id2= Doc_List[index].docid;
                                        if (kDebugMode) {
                                          print(index);
                                        }
                                        setState(() {
                                          int i;
                                          for(i=0; i<_selectedD.length; i++){
                                            _selectedD[i] = false;
                                          }
                                          if(_selectedD[index] == true){
                                            _selectedD[index] = false;
                                          }
                                          else{
                                            _selectedD[index] = true;
                                            b1=true;
                                          }
                                        });
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
                                          tileColor: _selectedD[index] ? Colors.blue : null,
                                          title: Text(
                                            Doc_List[index].docname,
                                            style: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),

                                        ),
                                      ),
                                    );
                                  },
                                    itemCount: Doc_List.length,
                                  ),
                                ),
                          ),
                          const SizedBox(height: 20,),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  disabledForegroundColor: Colors.blue.withOpacity(0.38), disabledBackgroundColor: Colors.blue.withOpacity(0.12)
                              ),
                              onPressed: b1 && b2
                                ? () {
                                scheduleapp(id2);
                                fToast = FToast();
                                fToast.init(context);
                                _showToast();
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Dashboard()));
                              } : null,
                              child: const Padding(
                                padding: EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
                                child: Text(
                                  'Schedule Appointment',                                    //making button to login to the dashboard.
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20,),
                        ],
                      ),
                    ),
                  ),
                ),

                ExpansionPanelList(
                  expansionCallback: (i, b) {
                    if (_selectedIndex == i) {
                      _selectedIndex = null;
                    }
                    else {
                      _selectedIndex = i;
                      _selectIndex = null;
                    }
                    setState(() {});
                  },
                  children: List.generate(
                    1,
                        (index) => ExpansionPanel(
                      canTapOnHeader: true,
                      isExpanded: index == _selectedIndex,
                      headerBuilder: (context, isExpanded) {
                        return vaccine[1];
                      },
                      body: Column(
                        children: [
                          SingleChildScrollView(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: ListView.builder(itemBuilder: (ctx,index){
                                return GestureDetector(
                                  onTap: (){
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                            title: Column(
                                              children: [
                                                ElevatedButton(
                                                    onPressed: (){
                                                      delapp(app[index].id);
                                                      fDToast = FToast();
                                                      fDToast.init(context);
                                                      _showDelToast();
                                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Dashboard()));
                                                    },
                                                    child: const Text('Delete Appointment',
                                                      style: TextStyle(fontSize: 25),)
                                                ),
                                                ElevatedButton(
                                                    onPressed: (){
                                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UpdateAppData(appid: app[index].id, chid: id1, doc: _selectedD.length, docSelect: app[index].doctorid.toString(), AOD: app[index].date.toString(), AOT: app[index].time.toString())));
                                                    },
                                                    child: const Text('Update Appointment',
                                                      style: TextStyle(fontSize: 25),)
                                                ),
                                              ],
                                            )
                                        ));
                                  },
                                  child: a ? Padding(
                                    padding: const EdgeInsets.only(left: 8, right: 8),
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
                                          app2[index].doctorid.toString(),
                                          style: const TextStyle(
                                            fontSize: 22,
                                            color: Colors.blueGrey,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        subtitle: Text('child: ${app2[index].childid}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        trailing: Column(
                                          children: [
                                            Text(app2[index].date.toString(),
                                              style: const TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                            const SizedBox(height: 10,),
                                            Text(
                                              app2[index].time.toString(),
                                              style: const TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ): Column(
                                    children: [
                                      const SizedBox(height: 50,),
                                      AlertDialog(
                                        title: Text(
                                          '',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.bebasNeue(
                                              color: const Color(0xFF607C8B),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        content: Text(
                                          "No Scheduled Appointments for this Child",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.bebasNeue(
                                              color: const Color(0xFF94B0C0),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  )
                                );
                              },
                                itemCount: app2.length,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20,),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  late FToast fToast;
  late FToast fDToast;

  _showToast() {
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
          Text("New Appointment Scheduled."),
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

  _showDelToast() {
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
          Text("Appointment Deleted."),
        ],
      ),
    );

    //setting up toast message location.
    fDToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }

  delapp(id2) async {
    Map data = {
      "id": id2,
    };
    var body = json.encode(data);
    var response = await http.post(Uri.parse("https://aya-uwindsor.herokuapp.com/docAppointment/delete"),
        headers: {"Content-Type": "application/json"},
        body: body
    );

    if (kDebugMode) {
      print(response.body);
    }
  }
}

class Vacc extends StatelessWidget {
  const Vacc(
      this.text,{
        Key? key,
      }): super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
        text,
        style: GoogleFonts.bebasNeue(
          fontSize: 42,
        )
    );
  }
}



