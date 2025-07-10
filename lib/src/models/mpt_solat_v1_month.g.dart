// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mpt_solat_v1_month.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MptSolatV1Month _$MptSolatV1MonthFromJson(Map<String, dynamic> json) =>
    MptSolatV1Month(
      prayerTimes: (json['prayerTime'] as List<dynamic>)
          .map((e) => MptPrayerTime.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String,
      serverTime: json['serverTime'] as String,
      periodType: json['periodType'] as String,
      lang: json['lang'] as String,
      zone: json['zone'] as String,
      bearing: json['bearing'] as String,
    );

Map<String, dynamic> _$MptSolatV1MonthToJson(MptSolatV1Month instance) =>
    <String, dynamic>{
      'prayerTime': instance.prayerTimes,
      'status': instance.status,
      'serverTime': instance.serverTime,
      'periodType': instance.periodType,
      'lang': instance.lang,
      'zone': instance.zone,
      'bearing': instance.bearing,
    };
