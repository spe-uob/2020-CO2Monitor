import 'package:co2_monitor/api/client.dart';
import 'package:co2_monitor/api/types/reading.dart';
import 'package:json_annotation/json_annotation.dart';
import 'link.dart';
import 'location.dart';

part 'group.g.dart';

/// Represents a group of locations, or internally, a 'building'.
@JsonSerializable()
class Group {
  @JsonKey(required: true)
  int id;
  String name;
  @JsonKey(required: true, name: "links")
  Link link;
  @JsonKey(ignore: true)
  ApiClient _client = ApiClient();

  Group(this.id, this.name, this.link);
  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  Map<String, dynamic> toJson() => _$GroupToJson(this);

  Future<List<Location>> locations() =>
      _client.getMany((l) => Location.fromJson(l), link.child);
}
