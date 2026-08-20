// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'solat_v2_endpoint.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$SolatV2Endpoint extends SolatV2Endpoint {
  _$SolatV2Endpoint([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = SolatV2Endpoint;

  @override
  Future<MPTWaktuSolatV2> getPrayerTimeByZone(
    String zone, {
    int? year,
    int? month,
  }) async {
    final Uri $url = Uri.parse('/v2/solat/${zone}');
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
    final Response $response = await client
        .send<MPTWaktuSolatV2, MPTWaktuSolatV2>($request);
    return $response.bodyOrThrow;
  }

  @override
  Future<MPTWaktuSolatV2> getPrayerTimeByGps(
    double lat,
    double long, {
    int? year,
    int? month,
  }) async {
    final Uri $url = Uri.parse('/v2/solat/${lat}/${long}');
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
    final Response $response = await client
        .send<MPTWaktuSolatV2, MPTWaktuSolatV2>($request);
    return $response.bodyOrThrow;
  }
}
