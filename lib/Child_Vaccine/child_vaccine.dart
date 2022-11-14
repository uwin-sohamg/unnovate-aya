import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:unnovate/Child_Vaccine/Vaccine.dart';

class ChildVaccine extends StatefulWidget{
  const ChildVaccine({super.key, required this.id});
  final int id;

  @override
  State<ChildVaccine> createState() => _ChildVaccine(id);
}

class _ChildVaccine extends State<ChildVaccine> {
  int id1=0;
  _ChildVaccine(id) {
    id1 = id;
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
    var data = id1;
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
        UpVac.add(VacList[i].vaccineid);

      i++;
    }
  }

  int? _selectedIndex=0;
  int? _selectIndex=1;
  final List<Vacc> vaccine = [
    const Vacc('Missed Vaccines'),
    const Vacc('Upcomming Vaccines'),
  ];

  @override
  void initState() {
    super.initState();
    int tak=0;
    getvac(id1);
  }

  List<Vaccine> VacList = [];
  List<String> MissedVac = [];
  List<String> UpVac = [];

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
                                    MissedVac[index],
                                    style: const TextStyle(
                                      fontSize: 22,
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                ),
                              );
                            },
                              itemCount: MissedVac.length,
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
                                return GestureDetector(
                                  onTap: (){
                                    if (kDebugMode) {
                                      print(index);
                                    }
                                    iid= VacList[index].id;
                                    ichid= VacList[index].childid;
                                    ivid = VacList[index].vaccineid;
                                    m = VacList[index].month;
                                    t= '1';
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
                                        UpVac[index],
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
                                itemCount: UpVac.length,
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
                                  Updatevac(iid, ichid, ivid, m, t);
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



