// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Device _$DeviceFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['id', 'links']);
  return Device(
    json['id'] as int,
    json['name'] as String,
    json['links'] == null
        ? null
        : Link.fromJson(json['links'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'links': instance.link,
    };
