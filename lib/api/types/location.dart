import 'package:co2_monitor/api/client.dart';
import 'package:co2_monitor/api/types/device.dart';
import 'package:co2_monitor/widgets/graphs/baseGraph.dart';
import 'package:co2_monitor/widgets/graphs/dataSet.dart';
import 'package:json_annotation/json_annotation.dart';
part 'location.g.dart';

// A location is a collection of SCK devices in near proximity.
// The intention is that each area (e.g. a room, building) will be a location.
@JsonSerializable(explicitToJson: true)
class Location extends IGraphable {
  @JsonKey(required: true)
  int id;
  String name;
  // List<Device> devices;

  @JsonKey(ignore: true)
  ApiClient _client = ApiClient();

  Location(this.id, this.name);
  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  // Mock value, can be used for testing and mocking UI
  factory Location.mock(int id) => Location(id, "Location $id");

  Map<String, dynamic> toJson() => _$LocationToJson(this);

  Future<List<Device>> devices() =>
      Future.sync(() => List.generate(5, (index) => Device.mock()));

  Future<Device> device(int id) => _client.getDevice(id);

  @override
  DataSet provideData() {
    // TODO: implement provideData
    throw UnimplementedError();
  }
}
