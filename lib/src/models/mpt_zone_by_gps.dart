import 'package:json_annotation/json_annotation.dart';

part 'mpt_zone_by_gps.g.dart';

@JsonSerializable()
class MptZoneByGPS {
  final String zone;
  final String state;
  final String district;

  MptZoneByGPS({
    required this.zone,
    required this.state,
    required this.district,
  });

  factory MptZoneByGPS.fromJson(Map<String, dynamic> json) =>
      _$MptZoneByGPSFromJson(json);
  Map<String, dynamic> toJson() => _$MptZoneByGPSToJson(this);
}
