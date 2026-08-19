import 'package:json_annotation/json_annotation.dart';

part 'chrono.g.dart';

@JsonSerializable()
class Chrono {
  final String date;
  @JsonKey(name: 'day_of_month')
  final int dayOfMonth;
  @JsonKey(name: 'day_of_week')
  final int dayOfWeek;
  final String time12;
  final String time24;
  final int unix;
  final String iso8601;
  final String timezone;

  Chrono({
    required this.date,
    required this.dayOfMonth,
    required this.dayOfWeek,
    required this.time12,
    required this.time24,
    required this.unix,
    required this.iso8601,
    required this.timezone,
  });

  factory Chrono.fromJson(Map<String, dynamic> json) => _$ChronoFromJson(json);
  Map<String, dynamic> toJson() => _$ChronoToJson(this);
}
