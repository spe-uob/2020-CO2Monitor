// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Group _$GroupFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['id', 'links']);
  return Group(
    json['id'] as int,
    json['name'] as String,
    json['links'] == null
        ? null
        : Link.fromJson(json['links'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'links': instance.link,
    };
