// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mpt_solat_v1_day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MptSolatV1Day _$MptSolatV1DayFromJson(Map<String, dynamic> json) =>
    MptSolatV1Day(
      prayerTimes: MptPrayerTime.fromJson(
        json['prayerTime'] as Map<String, dynamic>,
      ),
      status: json['status'] as String,
      serverTime: json['serverTime'] as String,
      periodType: json['periodType'] as String,
      lang: json['lang'] as String,
      zone: json['zone'] as String,
      bearing: json['bearing'] as String,
    );

Map<String, dynamic> _$MptSolatV1DayToJson(MptSolatV1Day instance) =>
    <String, dynamic>{
      'prayerTime': instance.prayerTimes,
      'status': instance.status,
      'serverTime': instance.serverTime,
      'periodType': instance.periodType,
      'lang': instance.lang,
      'zone': instance.zone,
      'bearing': instance.bearing,
    };
