import 'package:co2_monitor/api/client.dart';
import 'package:co2_monitor/api/types/reading.dart';
import 'package:json_annotation/json_annotation.dart';
import 'link.dart';

part 'device.g.dart';

/// Represents a physical SCK device in a fixed location.
@JsonSerializable()
class Device {
  @JsonKey(required: true)
  int id;
  String name;
  // String desc;
  @JsonKey(required: true, name: "links")
  Link link;
  @JsonKey(ignore: true)
  ApiClient _client = ApiClient();

  Device(this.id, this.name, this.link);
  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);

  // Mock value, can be used for testing and mocking UI
  // factory Device.mock() => Device(0, "Mock Device");

  Map<String, dynamic> toJson() => _$DeviceToJson(this);

  /// Dart does not allow us to instance methods as higher-order arguments.
  /// Let's define this here to avoid some code repetition.
  Reading Function(Map<String, dynamic>) _readingJson =
      (json) => Reading.fromJson(json);

  /// A list of all readings taken by this sensor.
  Future<List<Reading>> readings() =>
      _client.getMany(_readingJson, _fix(link.child));

  /// This function can be used to work-around a temporary bug in the API.
  /// In this bug, the children of sensors are shown as sensors themselves,
  /// rather than as readings
  String _fix(String child) {
    var start = child.lastIndexOf("/");
    return child.replaceRange(start, null, "/readings");
  }

  Future<List<Reading>> latestReadings(int count) =>
      _client.getMany(_readingJson, "${_fix(link.child)}/latest?amt=$count");

  Future<Reading> latestReading() =>
      _client.getMany(_readingJson, "${_fix(link.child)}/latest").then((arr) {
        if (arr.length == 0)
          return null;
        else
          return arr[0];
      });

  /// Determine if this device is critical. A device is considered critical if
  /// its latest reading is also considered critical.
  Future<bool> isCritical() => this.latestReading().then((read) {
        if (read != null)
          return read.isCritical;
        else
          return false;
      });
}
