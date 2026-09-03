// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mpt_prayer_time.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MptPrayerTime _$MptPrayerTimeFromJson(Map<String, dynamic> json) =>
    MptPrayerTime(
      hijri: HijriDate.fromJson(json['hijri'] as String),
      date: json['date'] as String,
      day: json['day'] as String,
      imsak: json['imsak'] as String,
      fajr: json['fajr'] as String,
      syuruk: json['syuruk'] as String,
      dhuha: json['dhuha'] as String,
      dhuhr: json['dhuhr'] as String,
      asr: json['asr'] as String,
      maghrib: json['maghrib'] as String,
      isha: json['isha'] as String,
    );

Map<String, dynamic> _$MptPrayerTimeToJson(MptPrayerTime instance) =>
    <String, dynamic>{
      'hijri': instance.hijri,
      'date': instance.date,
      'day': instance.day,
      'imsak': instance.imsak,
      'fajr': instance.fajr,
      'syuruk': instance.syuruk,
      'dhuha': instance.dhuha,
      'dhuhr': instance.dhuhr,
      'asr': instance.asr,
      'maghrib': instance.maghrib,
      'isha': instance.isha,
    };
