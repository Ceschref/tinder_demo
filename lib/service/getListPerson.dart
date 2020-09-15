import 'package:tinder_demo/model/person.dart';

class GetListPerson {

  List<Person> getListPerson(Map<String, dynamic> json) {
    var itemsJson = json['results'];
    List<Person> listItem = [];
    if (itemsJson is List) {
      listItem = itemsJson.map((item) => Person.fromJson(item)).toList();
    }
    return listItem;
  }
}