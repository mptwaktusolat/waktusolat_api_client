// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mpt_prayer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MptPrayer _$MptPrayerFromJson(Map<String, dynamic> json) => MptPrayer(
  day: (json['day'] as num).toInt(),
  hijri: HijriDate.fromJson(json['hijri'] as String),
  fajr: const EpochDateTimeConverter().fromJson((json['fajr'] as num).toInt()),
  syuruk: const EpochDateTimeConverter().fromJson(
    (json['syuruk'] as num).toInt(),
  ),
  dhuhr: const EpochDateTimeConverter().fromJson(
    (json['dhuhr'] as num).toInt(),
  ),
  asr: const EpochDateTimeConverter().fromJson((json['asr'] as num).toInt()),
  maghrib: const EpochDateTimeConverter().fromJson(
    (json['maghrib'] as num).toInt(),
  ),
  isha: const EpochDateTimeConverter().fromJson((json['isha'] as num).toInt()),
);

Map<String, dynamic> _$MptPrayerToJson(MptPrayer instance) => <String, dynamic>{
  'day': instance.day,
  'hijri': instance.hijri,
  'fajr': const EpochDateTimeConverter().toJson(instance.fajr),
  'syuruk': const EpochDateTimeConverter().toJson(instance.syuruk),
  'dhuhr': const EpochDateTimeConverter().toJson(instance.dhuhr),
  'asr': const EpochDateTimeConverter().toJson(instance.asr),
  'maghrib': const EpochDateTimeConverter().toJson(instance.maghrib),
  'isha': const EpochDateTimeConverter().toJson(instance.isha),
};
