import 'package:co2_monitor/api/client.dart';
import 'package:json_annotation/json_annotation.dart';
part 'reading.g.dart';

/// A single eCO2 reading taken by a designated device.
@JsonSerializable(explicitToJson: true)
class Reading {
  @JsonKey(name: "date")
  DateTime takenAt;
  bool get isCritical => value > 50;
  @JsonKey(name: "co2")
  int value;

  @JsonKey(ignore: true)
  ApiClient _client = ApiClient();

  Reading(this.takenAt, this.value);
  factory Reading.fromJson(Map<String, dynamic> json) {
    var self = _$ReadingFromJson(json);
    // Readings should be positive but Dart has no unsigned integer type
    assert(self.value >= 0);
    return self;
  }

  /// Mock value, can be used for testing and mocking UI
  factory Reading.mock() => Reading(DateTime.now(), 100);

  Map<String, dynamic> toJson() => _$ReadingToJson(this);
}
