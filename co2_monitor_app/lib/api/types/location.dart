import 'package:co2_monitor/api/types/device.dart';
import 'package:json_annotation/json_annotation.dart';
part 'location.g.dart';

// A location is a collection of SCK devices in near proximity.
// The intention is that each area (e.g. a room, building) will be a location.
@JsonSerializable(explicitToJson: true)
class Location {
  @JsonKey(required: true)
  String name;
  List<Device> devices;

  Location(this.name, this.devices);
  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
