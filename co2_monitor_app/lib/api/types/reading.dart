import 'package:json_annotation/json_annotation.dart';
part 'reading.g.dart';

// A single eCO2 reading taken by a designated device.
@JsonSerializable(explicitToJson: true)
class Reading {
  DateTime takenAt;
  bool isCritical;
  int value;

  Reading(this.takenAt, this.isCritical, this.value);
  factory Reading.fromJson(Map<String, dynamic> json) {
    var self = _$ReadingFromJson(json);
    // Readings should be positive but Dart has no unsigned integer type
    assert(self.value >= 0);
    return self;
  }

  Map<String, dynamic> toJson() => _$ReadingToJson(this);
}
