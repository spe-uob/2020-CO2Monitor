// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['id', 'link']);
  return Location(
    json['id'] as int,
    json['name'] as String,
  )..link = json['link'] == null
      ? null
      : Link.fromJson(json['link'] as Map<String, dynamic>);
}

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'link': instance.link?.toJson(),
    };
