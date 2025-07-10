// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mpt_zones.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MptZones _$MptZonesFromJson(Map<String, dynamic> json) => MptZones(
  zones: (json['zones'] as List<dynamic>)
      .map((e) => MptZone.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$MptZonesToJson(MptZones instance) => <String, dynamic>{
  'zones': instance.zones,
};
