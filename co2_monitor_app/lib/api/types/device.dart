import 'package:co2_monitor/api/types/reading.dart';
import 'package:json_annotation/json_annotation.dart';
part 'device.g.dart';

// Represents a physical SCK device in a fixed location.
@JsonSerializable(explicitToJson: true)
class Device {
  @JsonKey(required: true)
  int id;
  String name;
  List<Reading> readings;
  // Longitude and latitude provided by API for GPS location.
  double lat;
  double long;

  Device(this.id, this.name, this.readings, this.lat, this.long);
  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceToJson(this);
}
