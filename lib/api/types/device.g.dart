// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Device _$DeviceFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['id', 'link']);
  return Device(
    json['id'] as int,
    json['name'] as String,
  )
    ..desc = json['desc'] as String
    ..link = json['link'] == null
        ? null
        : Link.fromJson(json['link'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'desc': instance.desc,
      'link': instance.link?.toJson(),
    };
