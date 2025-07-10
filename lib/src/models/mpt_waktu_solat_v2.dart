import 'package:json_annotation/json_annotation.dart';
import 'package:waktusolat_api_client/src/models/mpt_prayer.dart';

part 'mpt_waktu_solat_v2.g.dart';

/// Model for "SOLAT V2" response
@JsonSerializable()
class MPTWaktuSolatV2 {
  final String zone;
  final int year;
  final String month;
  @JsonKey(name: 'month_number')
  final int monthNumber;
  @JsonKey(name: 'last_updated')
  final String? lastUpdated;
  final List<MptPrayer> prayers;

  MPTWaktuSolatV2({
    required this.zone,
    required this.year,
    required this.month,
    required this.monthNumber,
    this.lastUpdated,
    required this.prayers,
  });

  factory MPTWaktuSolatV2.fromJson(Map<String, dynamic> json) =>
      _$MPTWaktuSolatV2FromJson(json);
  Map<String, dynamic> toJson() => _$MPTWaktuSolatV2ToJson(this);
}
