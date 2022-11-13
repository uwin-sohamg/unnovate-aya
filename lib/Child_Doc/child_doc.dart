import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:unnovate/Child_Doc/Doctor.dart';
import 'package:unnovate/Child_Doc/appointment.dart';
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
    });
  }

  sepVac(){
    int i=0;
    while(i!=Doc_List.length){
      if (kDebugMode) {
        print(i);
      }
      MissedVac.add(Doc_List[i].docname);
      i++;
    }
    getapp();
  }

  int? _selectedIndex=0;
  int? _selectIndex=1;
  final List<Vacc> vaccine = [
    const Vacc('New Appointments'),
    const Vacc('Scheduled Appointments'),
  ];

  @override
  void initState() {
    super.initState();
    getvac();
  }


  TimeOfDay time = const TimeOfDay(hour: 12, minute: 30);


  var dateController = TextEditingController();
  var timeController = TextEditingController();

  List<Doc> Doc_List = [];
  List<Appointment> app = [];
  List<String> MissedVac = [];



  scheduleapp(int id3) async {

    Map data = {
      "childid":id1,
      "doctorid":id3,
      "date":dateController.text,
      "time" : timeController.text
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
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 70,),
                ExpansionPanelList(
                  expansionCallback: (i, b) {
                    if (_selectIndex == i){
                      _selectIndex = null;
                      _selectedIndex = i;
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
                                  ))),

                              IconButton(onPressed: () async {
                                TimeOfDay? newTime = await showTimePicker(context: context, initialTime: time);
                                if(newTime==null) return;
                                setState(() => timeController.text=newTime.toString());
                              }, icon: const Icon(Icons.timelapse)),

                              Expanded(
                                child: Text(
                                  '${time.hour}:${time.minute}',
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),

                            ],
                          ),

                          const SizedBox(height: 10),
                          SingleChildScrollView(
                            child: Container(
                                  height: MediaQuery.of(context).size.height * 0.5,
                                  child: ListView.builder(itemBuilder: (ctx,index){
                                    return GestureDetector(
                                      onTap: (){
                                        id2= Doc_List[index].docid;
                                        if (kDebugMode) {
                                          print(index);
                                        }
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
                                            Doc_List[index].docname,
                                            style: const TextStyle(
                                              fontSize: 22,
                                              color: Colors.blueGrey,
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
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child:   Container(
                              decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  scheduleapp(id2);
                                  fToast = FToast();
                                  fToast.init(context);
                                  _showToast();
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Dashboard()));
                                },
                                child:  Container(
                                  padding: const EdgeInsets.all(15),
                                  child: const Center(
                                    child:  Text(
                                      'Submit',                                    //making button to login to the dashboard.
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
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
                      _selectIndex = i;
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
                                return Card(
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
                                      app[index].doctorid.toString(),
                                      style: const TextStyle(
                                        fontSize: 22,
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text('child: ${app[index].childid}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    trailing: Column(
                                      children: [
                                        Text(app[index].date.toString(),
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(height: 10,),
                                        Text(
                                          app[index].time.toString(),
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                                itemCount: app.length,
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



