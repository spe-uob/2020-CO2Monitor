import 'package:json_annotation/json_annotation.dart';
part 'reading.g.dart';

// A single eCO2 reading taken by a designated device.
@JsonSerializable(explicitToJson: true)
class Reading {
  DateTime takenAt;
  bool isCritical;
  int value;

  Reading(this.takenAt, this.isCritical, this.value);
  factory Reading.fromJson(Map<String, dynamic> json) =>
      _$ReadingFromJson(json);

  Map<String, dynamic> toJson() => _$ReadingToJson(this);
}
