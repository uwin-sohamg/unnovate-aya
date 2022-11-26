import 'package:http/http.dart' as http;

class CharacterApi {
  static Future getCharacters() {
    return http.get(Uri.parse("https://aya-uwindsor.herokuapp.com/kidsprofile/read"));
  }
}

class User{
  late final String kidname;
  late final String age;
  late final String gender;
  late final int id;

  User.fromJson(Map json)
      : kidname = json["name"],
        age = json["dob"],
        id = json["id"],
        gender = json["gender"];

  Map toJson(){
    return {
      "name": kidname, "dob": age, "gender": gender, "id": id
    };
  }

  User(this.kidname, this.age, this.gender);
}