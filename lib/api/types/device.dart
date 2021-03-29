import 'package:co2_monitor/api/client.dart';
import 'package:co2_monitor/api/types/reading.dart';
import 'package:json_annotation/json_annotation.dart';
import 'link.dart';

part 'device.g.dart';

/// Represents a physical SCK device in a fixed location.
@JsonSerializable(explicitToJson: true)
class Device {
  @JsonKey(required: true)
  int id;
  String name;
  String desc;
  @JsonKey(required: true)
  Link link;
  @JsonKey(ignore: true)
  ApiClient _client = ApiClient();

  Device(this.id, this.name);
  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);

  // Mock value, can be used for testing and mocking UI
  factory Device.mock() => Device(0, "Mock Device");

  Map<String, dynamic> toJson() => _$DeviceToJson(this);

  /// A list of all readings taken by this sensor.
  Future<List<Reading>> readings() => _client.getMany(link.children);

  /// Determine if this device is critical. A device is considered critical if
  /// its latest reading is also considered critical.
  Future<bool> isCritical() =>
      this.latestReading().then((read) => read.isCritical);

  // TODO: Why isn't this defined properly in this Hell API
  Future<Reading> latestReading() => readings().then((rs) => rs.first);
}
