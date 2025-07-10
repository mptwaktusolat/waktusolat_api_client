import 'package:json_annotation/json_annotation.dart';
import 'package:waktusolat_api_client/src/models/mpt_prayer_time.dart';

part 'mpt_solat_v1_month.g.dart';

@JsonSerializable()
class MptSolatV1Month {
  @JsonKey(name: 'prayerTime')
  final List<MptPrayerTime> prayerTimes;
  final String status;
  final String serverTime;
  final String periodType;
  final String lang;
  final String zone;
  final String bearing;

  MptSolatV1Month({
    required this.prayerTimes,
    required this.status,
    required this.serverTime,
    required this.periodType,
    required this.lang,
    required this.zone,
    required this.bearing,
  });

  factory MptSolatV1Month.fromJson(Map<String, dynamic> json) =>
      _$MptSolatV1MonthFromJson(json);
  Map<String, dynamic> toJson() => _$MptSolatV1MonthToJson(this);
}
