import 'package:json_annotation/json_annotation.dart';

part 'scan_model.g.dart';

@JsonSerializable()
class ScanModel {
  final int id;
  final String name;
  final String tag;
  final String color;
  final List<Criteria> criteria;

  ScanModel({required this.id, required this.name, required this.tag, required this.color, required this.criteria});

  factory ScanModel.fromJson(Map<String, dynamic> json) => _$ScanModelFromJson(json);
  Map<String, dynamic> toJson() => _$ScanModelToJson(this);
}

@JsonSerializable()
class Criteria {
  final String type;
  final String text;
  final Map<String, dynamic>? variable;

  Criteria({required this.type, required this.text, this.variable});

  factory Criteria.fromJson(Map<String, dynamic> json) => _$CriteriaFromJson(json);
  Map<String, dynamic> toJson() => _$CriteriaToJson(this);
}
