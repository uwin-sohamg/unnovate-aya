import 'package:http/http.dart' as http;

class AppCharacterApi {
  static Future getAppCharacters() {
    return http.get(Uri.parse("https://aya-uwindsor.herokuapp.com/docAppointment/read"));
  }
}


class Appointment{
  late final String childid;
  late final String doctorid;
  late final String date;
  late final String time;
  late final int id;

  Appointment.fromJson(Map json)
      : childid = json["childid"],
        doctorid = json["doctorid"],
        date = json["date"],
        id = json["id"],
        time = json["time"];

  Map toJson(){
    return {
      "childid": childid, "doctorid": doctorid, "date": date, "time": time, id: "id"
    };
  }

  Appointment(this.childid, this.doctorid, this.date, this.time);
}