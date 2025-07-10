import 'package:json_annotation/json_annotation.dart';

part 'mpt_prayer_time.g.dart';

@JsonSerializable()
class MptPrayerTime {
  final String hijri;
  final String date;
  final String day;
  final String fajr;
  final String syuruk;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;

  MptPrayerTime({
    required this.hijri,
    required this.date,
    required this.day,
    required this.fajr,
    required this.syuruk,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });

  factory MptPrayerTime.fromJson(Map<String, dynamic> json) =>
      _$MptPrayerTimeFromJson(json);
  Map<String, dynamic> toJson() => _$MptPrayerTimeToJson(this);
}
