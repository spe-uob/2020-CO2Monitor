import 'package:co2_monitor/api/client.dart';
import 'package:co2_monitor/api/types/device.dart';
import 'package:json_annotation/json_annotation.dart';
part 'location.g.dart';

// A location is a collection of SCK devices in near proximity.
// The intention is that each area (e.g. a room, building) will be a location.
@JsonSerializable(explicitToJson: true)
class Location {
  @JsonKey(required: true)
  String name;
  // List<Device> devices;

  @JsonKey(ignore: true)
  ApiClient _client = ApiClient();

  Location(this.name);
  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  // Mock value, can be used for testing and mocking UI
  factory Location.mock() => Location("Dummy Location");

  Map<String, dynamic> toJson() => _$LocationToJson(this);

  Future<List<Device>> devices() => _client.getDevices("");

  Future<Device> device(int id) => _client.getDevice("");
}
