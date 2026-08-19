// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'solat_v1_endpoint.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$SolatV1Endpoint extends SolatV1Endpoint {
  _$SolatV1Endpoint([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = SolatV1Endpoint;

  @override
  Future<Response<MptSolatV1Month>> getMonthlyPrayerTime(
    String zone, {
    int? year,
    int? month,
  }) {
    final Uri $url = Uri.parse('/solat/${zone}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'year': year,
      'month': month,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<MptSolatV1Month, MptSolatV1Month>($request);
  }

  @override
  Future<Response<MptSolatV1Month>> getDailyPrayerTime(
    String zone,
    int day, {
    int? year,
    int? month,
  }) {
    final Uri $url = Uri.parse('/solat/${zone}/${day}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'year': year,
      'month': month,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<MptSolatV1Month, MptSolatV1Month>($request);
  }
}
