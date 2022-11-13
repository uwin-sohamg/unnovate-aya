import 'package:http/http.dart' as http;

class DocCharacterApi {
  static Future getDocCharacters() {
    return http.get(Uri.parse("https://aya-uwindsor.herokuapp.com/doctorList/read"));
  }
}


class Doc{
  late final int docid;
  late final String docname;
  late final String specialist;
  late final String address;
  late final String mobileno;

  Doc.fromJson(Map json)
      : docid = json["docid"],
        docname = json["docname"],
        specialist = json["specialist"],
        mobileno = json["mobileno"],
        address = json["address"];

  Map toJson(){
    return {
      "docid": docid, "docname": docname, "specialist": specialist, "mobileno": mobileno, "address": address
    };
  }

  Doc(this.docid, this.docname, this.specialist, this.mobileno);
}