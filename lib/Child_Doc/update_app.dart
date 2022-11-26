import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:unnovate/Child_Doc/Doctor.dart';
import 'package:unnovate/Dashboard/dashboard.dart';
import 'package:intl/intl.dart';

class UpdateAppData extends StatefulWidget{

  const UpdateAppData({super.key, required this.appid, required this.chid, required this.doc, required this.docSelect, required this.AOD, required this.AOT});
  final int appid;
  final int chid;
  final int doc;
  final String docSelect;
  final String AOD;
  final String AOT;

  @override
  _UpdateAppData createState() => _UpdateAppData(appid, chid, doc, docSelect, AOD, AOT);
}

class _UpdateAppData extends State<UpdateAppData> {

  int id2=0;
  int id1=0;
  int id=0;
  int doc1=0;
  int docSelect1=0;
  String AOD1= '';
  String AOT1= '';
  _UpdateAppData(appid, chid, doc, docSelect, AOD, AOT) {
    id1 = chid;
    id = appid;
    doc1 = doc;
    docSelect1 = int.parse(docSelect);
    AOD1 = AOD;
    AOT1 = AOT;
  }

  List<Doc> Doc_List = [];
  List<bool> _selectedD = [];


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
  }

  TimeOfDay stringToTimeOfDay(String tod) {
    final format = DateFormat.jm(); //"6:00 AM"
    return TimeOfDay.fromDateTime(format.parse(tod));
  }

  selecDoc(){
    dateController.text = AOD1;
    time = stringToTimeOfDay(AOT1);
    for(int ct=0; ct<doc1; ct++){
      if(ct == docSelect1-1){
        _selectedD.add(true);
        if (kDebugMode) {
          print(_selectedD[ct]);
        }
      }
      else{
        _selectedD.add(false);
        if (kDebugMode) {
          print(_selectedD[ct]);
        }
      }
    }
  }

  var dateController = TextEditingController();
  TimeOfDay time = const TimeOfDay(hour: 12, minute: 30);

  @override
  Widget build(BuildContext context) {

    Updateapp(int iid1, int iid2,int iid3) async {
      Map data = {
        "id":iid1,
        "childid":iid2,
        "doctorid":iid3,
        "date":dateController.text,
        "time" : time.format(context)
      };
      var body = json.encode(data);
      var response = await http.post(Uri.parse("https://aya-uwindsor.herokuapp.com/docAppointment/update"),
          headers: {"Content-Type": "application/json"},
          body: body
      );

      if (kDebugMode) {
        print(response.body);
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 70,),
            const Text('Update Appointment Details',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 30,),
            Column(
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child:   Container(
                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextButton(
                            onPressed: () {
                              Updateapp(id, id1, id2);
                              fToast = FToast();
                              fToast.init(context);
                              _showToast();
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Dashboard()));
                            },
                            child:  Container(
                              padding: const EdgeInsets.all(15),
                              child: const Center(
                                child:  Text(
                                  'Update',                                    //making button to login to the dashboard.
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
          ],
        ),
      ),
    );
  }

  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    getvac();
    selecDoc();
  }

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
          Text("Appointment Updated Successfully."),
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