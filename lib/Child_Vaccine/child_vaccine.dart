import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:unnovate/Child_Vaccine/Vaccine.dart';
import 'package:unnovate/Child_Vaccine/vacc_nav.dart';

class ChildVaccine extends StatefulWidget{
  const ChildVaccine({super.key, required this.id, required this.dob});
  final int id;
  final String dob;

  @override
  State<ChildVaccine> createState() => _ChildVaccine(id, dob);
}

class _ChildVaccine extends State<ChildVaccine> {
  int id1=0;
  DateTime now = DateTime.now();
  DateTime dob1= DateTime.now();
  var chmonth;
  var cmonth;
  var vmonth;
  int b1=0;
  int b2=0;

  _ChildVaccine(id, dob) {
    id1 = id;
    dob1= DateTime.parse(dob);
    cmonth = now.difference(dob1).inDays/30;
    chmonth = cmonth.round();
  }

  int iid=0;
  String ichid= '';
  String ivid= '';
  String m= '';
  String t= '';


  Updatevac(int iid2, String ichid2,String ivid2, String m2, String t2) async {
    Map data = {
      "id":iid2,
      "childid":ichid2,
      "vaccineid":ivid2,
      "month":m2,
      "taken" : t2
    };
    var body = json.encode(data);
    var response = await http.post(Uri.parse("https://aya-uwindsor.herokuapp.com/childvaccinedetails/update"),
        headers: {"Content-Type": "application/json"},
        body: body
    );

    if (kDebugMode) {
      print(response.body);
    }
  }

  getvac(id2) async {
    var data = id2;
    var body = json.encode(data);
    var response = await http.post(Uri.parse("https://aya-uwindsor.herokuapp.com/childvaccinedetails/read"),
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
      VacList = list.map((model) => Vaccine.fromJson(model)).toList();
    });
    sepVac();
  }

  sepVac(){
    int i=0;
    while(i!=VacList.length){
      if (kDebugMode) {
        print(i);
      }
      if (kDebugMode) {
        print('$chmonth ${VacList[i].month}');
      }
      vmonth= int.parse(VacList[i].month);

      if(vmonth>= chmonth){
        UpVac.add(VacList[i].vaccineid);
        _selectedU.add(false);
      }
      else{
        MissedVac.add(VacList[i].vaccineid);
        _selectedM.add(false);
      }
      i++;
    }
  }

  int? _selectedIndex=0;
  int? _selectIndex=1;
  final List<Vacc> vaccine = [
    const Vacc('   Missed Vaccines'),
    const Vacc('   Upcoming Vaccines'),
  ];

  @override
  void initState() {
    super.initState();
    int tak=1;
    getvac(id1);
    mlen= MissedVac.length;
    uplen= UpVac.length;
  }

  List<Vaccine> VacList = [];
  List<String> MissedVac = [];
  List<String> UpVac = [];
  int mlen= 0;
  int uplen= 0;
  List<bool> _selectedM = [];
  List<bool> _selectedU = [];
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {

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
              mainAxisAlignment: MainAxisAlignment.center,
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
                                  tileColor: _selectedM[index] ? Colors.blue : null,
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        MissedVac[index],
                                        style: const TextStyle(
                                          fontSize: 22,
                                          color: Colors.blueGrey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Checkbox(
                                        value: _selectedM[index],
                                        onChanged: (bool? value) {
                                          setState(() {
                                            if (kDebugMode) {
                                              print(index);
                                            }
                                            iid= VacList[index].id;
                                            ichid= VacList[index].childid;
                                            ivid = VacList[index].vaccineid;
                                            m = VacList[index].month;
                                            t= '1';
                                            if (kDebugMode) {
                                              print(_selectedM[index]);
                                            }
                                            if(_selectedM[index] == true){
                                              _selectedM[index] = false;
                                              _selectedM[index] = value!;
                                            }
                                            else{
                                              _selectedM[index] = true;
                                              _selectedM[index] = value!;
                                            }
                                            if (kDebugMode) {
                                              print(_selectedM[index]);
                                            }
                                            for(int i=0; i< _selectedM.length; i++){
                                              if(_selectedM[index]==true){
                                                b1++;
                                              }
                                              else{
                                                b1--;
                                              }
                                            }
                                          });
                                        },
                                      )
                                    ],
                                  ),

                                ),
                              );
                            },
                              itemCount: MissedVac.length,
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
                              onPressed: b1>0 ? () {
                                Updatevac(iid, ichid, ivid, m, t);
                                Navigator.of(context).popUntil((route) => route.isFirst);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const VacNav()));
                              } : null,
                              child: const Padding(
                                padding: EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
                                child: Text(
                                  'Submit',                                    //making button to login to the dashboard.
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
                                    tileColor: _selectedU[index] ? Colors.blue : null,
                                      title: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            UpVac[index],
                                            style: const TextStyle(
                                              fontSize: 22,
                                              color: Colors.blueGrey,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Checkbox(
                                            value: _selectedU[index],
                                            onChanged: (bool? value) {
                                              setState(() {
                                                if (kDebugMode) {
                                                  print(index);
                                                }
                                                iid= VacList[index].id;
                                                ichid= VacList[index].childid;
                                                ivid = VacList[index].vaccineid;
                                                m = VacList[index].month;
                                                t= '1';
                                                if (kDebugMode) {
                                                  print(_selectedU[index]);
                                                }
                                                if(_selectedU[index] == true){
                                                  _selectedU[index] = false;
                                                  _selectedU[index] = value!;
                                                }
                                                else{
                                                  _selectedU[index] = true;
                                                  _selectedU[index] = value!;
                                                }
                                                if (kDebugMode) {
                                                  print(_selectedU[index]);
                                                }
                                                for(int i=0; i< _selectedU.length; i++){
                                                  if(_selectedU[index]==true){
                                                    b2++;
                                                  }
                                                  else{
                                                    b2--;
                                                  }
                                                }
                                              });
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                );
                              },
                                itemCount: UpVac.length,
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
                              onPressed: b2> 0 ? () {
                                Updatevac(iid, ichid, ivid, m, t);
                                Navigator.of(context).popUntil((route) => route.isFirst);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const VacNav()));
                              } : null,
                              child: const Padding(
                                padding: EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
                                child: Text(
                                  'Submit',                                    //making button to login to the dashboard.
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

              ],
            ),
          ),
        ),
      ),
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



