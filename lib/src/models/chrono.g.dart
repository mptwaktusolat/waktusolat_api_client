// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chrono.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chrono _$ChronoFromJson(Map<String, dynamic> json) => Chrono(
  date: json['date'] as String,
  dayOfMonth: (json['day_of_month'] as num).toInt(),
  dayOfWeek: (json['day_of_week'] as num).toInt(),
  time12: json['time12'] as String,
  time24: json['time24'] as String,
  unix: (json['unix'] as num).toInt(),
  iso8601: json['iso8601'] as String,
  timezone: json['timezone'] as String,
);

Map<String, dynamic> _$ChronoToJson(Chrono instance) => <String, dynamic>{
  'date': instance.date,
  'day_of_month': instance.dayOfMonth,
  'day_of_week': instance.dayOfWeek,
  'time12': instance.time12,
  'time24': instance.time24,
  'unix': instance.unix,
  'iso8601': instance.iso8601,
  'timezone': instance.timezone,
};
