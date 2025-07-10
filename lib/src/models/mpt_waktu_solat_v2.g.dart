// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mpt_waktu_solat_v2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MPTWaktuSolatV2 _$MPTWaktuSolatV2FromJson(Map<String, dynamic> json) =>
    MPTWaktuSolatV2(
      zone: json['zone'] as String,
      year: (json['year'] as num).toInt(),
      month: json['month'] as String,
      monthNumber: (json['month_number'] as num).toInt(),
      lastUpdated: json['last_updated'] as String?,
      prayers: (json['prayers'] as List<dynamic>)
          .map((e) => MptPrayer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MPTWaktuSolatV2ToJson(MPTWaktuSolatV2 instance) =>
    <String, dynamic>{
      'zone': instance.zone,
      'year': instance.year,
      'month': instance.month,
      'month_number': instance.monthNumber,
      'last_updated': instance.lastUpdated,
      'prayers': instance.prayers,
    };
