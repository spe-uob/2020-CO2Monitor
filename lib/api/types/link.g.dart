// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Link _$LinkFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['self', 'child']);
  return Link(
    json['self'] as String,
    json['child'] as String,
  );
}

Map<String, dynamic> _$LinkToJson(Link instance) => <String, dynamic>{
      'self': instance.self,
      'child': instance.child,
    };
