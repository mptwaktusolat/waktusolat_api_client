import 'package:json_annotation/json_annotation.dart';

part 'mpt_zone.g.dart';

/// Represents a zone object
@JsonSerializable()
class MptZone {
  /// The Jakim zone code, e.g., 'SGR01'
  final String jakimCode;

  /// The state name, e.g., 'Selangor'
  final String negeri;

  /// The area that is covered by this zone, e.g., 'Petaling'. This 'daerah' is not
  /// strictly the district, but rather the area that is covered by this zone.
  final String daerah;

  MptZone({
    required this.jakimCode,
    required this.negeri,
    required this.daerah,
  });

  factory MptZone.fromJson(Map<String, dynamic> json) =>
      _$MptZoneFromJson(json);
  Map<String, dynamic> toJson() => _$MptZoneToJson(this);

  static List<MptZone> fromList(List<dynamic> list) =>
      list.map((e) => MptZone.fromJson(e as Map<String, dynamic>)).toList();
}
