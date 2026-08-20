// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'zones_endpoint.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$ZonesEndpoint extends ZonesEndpoint {
  _$ZonesEndpoint([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = ZonesEndpoint;

  @override
  Future<List<MptZone>> getAllZones() async {
    final Uri $url = Uri.parse('/zones');
    final Request $request = Request('GET', $url, client.baseUrl);
    final Response $response = await client.send<List<MptZone>, MptZone>(
      $request,
    );
    return $response.bodyOrThrow;
  }

  @override
  Future<List<MptZone>> getZonesByState(String state) async {
    final Uri $url = Uri.parse('/zones/${state}');
    final Request $request = Request('GET', $url, client.baseUrl);
    final Response $response = await client.send<List<MptZone>, MptZone>(
      $request,
    );
    return $response.bodyOrThrow;
  }

  @override
  Future<MptZoneByGPS> getZonesByGps(double lat, double long) async {
    final Uri $url = Uri.parse('/zones/${lat}/${long}');
    final Request $request = Request('GET', $url, client.baseUrl);
    final Response $response = await client.send<MptZoneByGPS, MptZoneByGPS>(
      $request,
    );
    return $response.bodyOrThrow;
  }
}
