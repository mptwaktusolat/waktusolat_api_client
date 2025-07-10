import 'package:json_annotation/json_annotation.dart';
import 'package:waktusolat_api_client/src/converters/epoch_date_time_converter.dart';
import 'hijri_date.dart';

part 'mpt_prayer.g.dart';

@JsonSerializable()
class MptPrayer {
  final int day;
  final HijriDate hijri;
  @EpochDateTimeConverter()
  final DateTime fajr;
  @EpochDateTimeConverter()
  final DateTime syuruk;
  @EpochDateTimeConverter()
  final DateTime dhuhr;
  @EpochDateTimeConverter()
  final DateTime asr;
  @EpochDateTimeConverter()
  final DateTime maghrib;
  @EpochDateTimeConverter()
  final DateTime isha;

  MptPrayer({
    required this.day,
    required this.hijri,
    required this.fajr,
    required this.syuruk,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });

  factory MptPrayer.fromJson(Map<String, dynamic> json) =>
      _$MptPrayerFromJson(json);
  Map<String, dynamic> toJson() => _$MptPrayerToJson(this);
}
