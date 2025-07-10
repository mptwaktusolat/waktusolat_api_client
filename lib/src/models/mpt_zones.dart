import 'package:json_annotation/json_annotation.dart';
import 'package:waktusolat_api_client/src/models/mpt_zone.dart';

part 'mpt_zones.g.dart';

@JsonSerializable()
class MptZones {
  final List<MptZone> zones;

  MptZones({required this.zones});

  factory MptZones.fromJson(Map<String, dynamic> json) =>
      _$MptZonesFromJson(json);
  Map<String, dynamic> toJson() => _$MptZonesToJson(this);
}
