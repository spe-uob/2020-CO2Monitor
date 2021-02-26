// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reading _$ReadingFromJson(Map<String, dynamic> json) {
  return Reading(
    json['date'] == null ? null : DateTime.parse(json['date'] as String),
    json['co2'] as int,
  );
}

Map<String, dynamic> _$ReadingToJson(Reading instance) => <String, dynamic>{
      'date': instance.takenAt?.toIso8601String(),
      'co2': instance.value,
    };
