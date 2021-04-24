import 'package:co2_monitor/api/client.dart';
import 'package:co2_monitor/api/types/device.dart';
import 'package:co2_monitor/widgets/graphs/baseGraph.dart';
import 'package:co2_monitor/widgets/graphs/dataSet.dart';
import 'package:json_annotation/json_annotation.dart';
import 'link.dart';

part 'location.g.dart';

/// A location is a collection of SCK devices in near proximity.
/// The intention is that each area (e.g. a room, building) will be a location.
@JsonSerializable()
class Location extends IGraphable {
  @JsonKey(required: true)
  int id;
  String name;
  @JsonKey(required: true, name: "links")
  Link link;
  @JsonKey(ignore: true)
  ApiClient _client = ApiClient();

  Location(this.id, this.name, this.link);
  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  /// Mock value, can be used for testing and mocking UI
  // factory Location.mock(int id) => Location(id, "Location $id");

  Map<String, dynamic> toJson() => _$LocationToJson(this);

  Future<List<Device>> devices() =>
      _client.getMany((j) => Device.fromJson(j), link.child);

  /// Determine if a location is considered critical to occupy based on its
  /// component sensors. For the time being, any locatiom with one critical
  /// sensors is itself considered critical.
  Future<bool> isCritical() async {
    var devices = await this.devices();
    for (var device in devices) if (await device.isCritical()) return true;
    return false;
  }

  @override
  // TODO: Implement provideData
  DataSet provideData() => DataSet.usingSampleSeries();
}
