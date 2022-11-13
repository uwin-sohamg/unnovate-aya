import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PCharacterApi {
  static Future getPCharacters() {
    return http.get(Uri.parse("https://aya-uwindsor.herokuapp.com/parentdetails/read"));
  }
}

class Parent{
  late final String parentsname;
  late final String emailid;
  late final String mobileno;
  late final int id;

  Parent.fromJson(Map json)
      : parentsname = json["parentsname"],
        emailid = json["emailid"],
        mobileno = json["mobileno"],
        id = json["id"];

  Map toJson(){
    return {
      "parentsname": parentsname, "emailid": emailid, "mobileno": mobileno, "id": id
    };
  }

  Parent(this.parentsname, this.emailid, this.mobileno);
}