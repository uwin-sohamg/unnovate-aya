import 'package:flutter/material.dart';

class Vaccine{
  late final String vaccinename;
  late final int id;

  Vaccine.fromJson(Map json)
      : vaccinename = json["vaccinename"],
        id = json["id"];

  Map toJson(){
    return {
      "vaccinename": vaccinename, "id": id
    };
  }
}