// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reading _$ReadingFromJson(Map<String, dynamic> json) {
  return Reading(
    json['takenAt'] == null ? null : DateTime.parse(json['takenAt'] as String),
    json['isCritical'] as bool,
    json['value'] as int,
  );
}

Map<String, dynamic> _$ReadingToJson(Reading instance) => <String, dynamic>{
      'takenAt': instance.takenAt?.toIso8601String(),
      'isCritical': instance.isCritical,
      'value': instance.value,
    };
