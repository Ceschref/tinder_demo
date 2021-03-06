// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) {
  return Person(
    json['id'] as int,
    json['name'] == null ? null : Name.fromJson(json['name']),
    json['old'] as int,
    json['location'] == null ? null : Location.fromJson(json['location']),
    json['sex'] as String,
    json['image'] as String,
    json['number_phone'] as String,
    json['image_url'] as String,
  );
}

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'old': instance.old,
      'sex': instance.sex,
      'location': instance.location,
      'image': instance.image,
      'number_phone': instance.numberPhone,
      'image_url': instance.imageUrl,
    };

Name _$NameFromJson(Map<String, dynamic> json) {
  return Name(
    json['first'] as String,
    json['last'] as String,
  );
}

Map<String, dynamic> _$NameToJson(Name instance) => <String, dynamic>{
      'first': instance.first,
      'last': instance.last,
    };

Location _$LocationFromJson(Map<String, dynamic> json) {
  return Location(
    json['street'] as String,
    json['city'] as String,
    json['state'] as String,
    json['postcode'] as int,
  );
}

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'street': instance.street,
      'city': instance.city,
      'state': instance.state,
      'postcode': instance.postcode,
    };
