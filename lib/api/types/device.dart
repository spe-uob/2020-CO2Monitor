import 'package:co2_monitor/api/client.dart';
import 'package:co2_monitor/api/types/reading.dart';
import 'package:json_annotation/json_annotation.dart';
part 'device.g.dart';

// Represents a physical SCK device in a fixed location.
@JsonSerializable(explicitToJson: true)
class Device {
  @JsonKey(required: true)
  int id;
  String name;
  // Longitude and latitude provided by API for GPS location.
  double lat;
  double long;

  @JsonKey(ignore: true)
  ApiClient _client = ApiClient();

  Device(this.id, this.name, this.lat, this.long);
  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);

  // Mock value, can be used for testing and mocking UI
  factory Device.mock() => Device(0, "Mock Device", 10, 10);

  Map<String, dynamic> toJson() => _$DeviceToJson(this);

  Future<List<Reading>> readings() => _client.getReadings("");

  Future<Reading> reading(int id) => _client.getReading("");
}
