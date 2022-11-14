import 'package:flutter/material.dart';

class Vaccine{
  late final String childid;
  late final String vaccineid;
  late final String month;
  late final String taken;
  late final int id;

  Vaccine.fromJson(Map json)
      : childid = json["childid"],
        vaccineid = json["vaccineid"],
        month = json["month"],
        taken = json["taken"],
        id = json["id"];

  Map toJson(){
    return {
      "childid": childid, "vaccineid":vaccineid, "month":month, "taken":taken, "id": id
    };
  }
}