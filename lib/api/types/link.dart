import 'package:json_annotation/json_annotation.dart';
part 'link.g.dart';

/// Internal API detail which specifies navigation between elements children.
@JsonSerializable(explicitToJson: true)
class Link {
  String self;
  String children;

  Link(this.self, this.children);
  factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);
  Map<String, dynamic> toJson() => _$LinkToJson(this);
}
