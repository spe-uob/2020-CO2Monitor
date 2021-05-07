import 'package:co2_monitor/api/client.dart';
import 'package:co2_monitor/api/types/device.dart';
import 'package:co2_monitor/widgets/graphs/baseGraph.dart';
import 'package:co2_monitor/widgets/graphs/graphData.dart';
import 'package:co2_monitor/widgets/graphs/lineData.dart';
import 'package:json_annotation/json_annotation.dart';
import 'group.dart';
import 'link.dart';

part 'location.g.dart';

/// A location is a collection of SCK devices in near proximity.
/// The intention is that each area (e.g. a room, building) will be a location.
@JsonSerializable()
class Location implements IGraphable {
  @JsonKey(required: true)
  int id;
  String name;
  @JsonKey(required: true, name: "links")
  Link link;
  @JsonKey(ignore: true)
  Group _group;
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
    var crits = await Future.wait(devices.map((dev) => dev.isCritical()));
    return crits.any((e) => e);
  }

  String groupName() {
    switch (this._group.name) {
      case "MVB":
        return "Merchant Venturers Building";
      case "Queens":
        return "Queen's Building";
      default:
        return this._group.name;
    }
  }

  Location withGroup(Group group) {
    this._group = group;
    return this;
  }

  @override
  Future<GraphData> provideData() async {
    var devices = await this.devices();
    var lines = await Future.wait(devices.map((dev) => dev.provideData()));
    var ret = GraphData(lines.map((l) => l.lines).expand((e) => e).toList());
    return ret;
  }
}
