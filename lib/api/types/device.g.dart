// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Device _$DeviceFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['id']);
  return Device(
    json['id'] as int,
    json['name'] as String,
    (json['lat'] as num)?.toDouble(),
    (json['long'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lat': instance.lat,
      'long': instance.long,
    };
