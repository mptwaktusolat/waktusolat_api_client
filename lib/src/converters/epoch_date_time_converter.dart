import 'package:json_annotation/json_annotation.dart';

/// Converter for converting epoch time (in seconds) to DateTime and vice versa
class EpochDateTimeConverter implements JsonConverter<DateTime, int> {
  const EpochDateTimeConverter();

  @override
  DateTime fromJson(int json) =>
      DateTime.fromMillisecondsSinceEpoch(json * 1000);

  @override
  int toJson(DateTime object) => (object.millisecondsSinceEpoch / 1000).round();
}
