import 'package:json_annotation/json_annotation.dart';
part 'link.g.dart';

/// Internal API detail which specifies navigation between elements children.
@JsonSerializable()
class Link {
  @JsonKey(required: true)
  String self;
  @JsonKey(required: true)
  String child;

  Link(this.self, this.child);
  factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);
  Map<String, dynamic> toJson() => _$LinkToJson(this);
}
