import 'package:json_annotation/json_annotation.dart';

part 'person.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Person {
  int id;
  Name name;
  int old;
  String sex;
  Location location;
  String image;
  String numberPhone;
  String imageUrl;

  Person(this.id, this.name, this.old, this.location, this.sex, this.image, this.numberPhone, this.imageUrl);

  factory Person.fromJson(dynamic json) => _$PersonFromJson(json);
}

@JsonSerializable()
class Name {
  String first;
  String last;

  Name(this.first, this.last);
  factory Name.fromJson(dynamic json) => _$NameFromJson(json);
}

@JsonSerializable()
class Location {
  String street;
  String city;
  String state;
  int postcode;

  Location(this.street, this.city, this.state, this.postcode);
  factory Location.fromJson(dynamic json) => _$LocationFromJson(json);
}
