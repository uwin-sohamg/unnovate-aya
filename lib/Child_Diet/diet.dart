import 'package:flutter/material.dart';


class Diet{
  late final int id;
  late final String childage;
  late final String gender;
  late final String calories;
  late final String protein;
  late final String dairy;
  late final String food;

  Diet.fromJson(Map json)
      : childage = json["childage"],
        gender = json["gender"],
        calories = json["calories"],
        protein = json["protein"],
        dairy = json["dairy"],
        food = json["food"],
        id = json["id"];

  Map toJson(){
    return {
      "childage": childage, "gender":gender, "calories":calories, "protein":protein, "dairy":dairy, "food":food, "id": id
    };
  }
}