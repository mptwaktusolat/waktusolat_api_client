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
  Future<Response<List<MptZone>>> getAllZones() {
    final Uri $url = Uri.parse('/zones');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<List<MptZone>, MptZone>($request);
  }

  @override
  Future<Response<List<MptZone>>> getZonesByState(String state) {
    final Uri $url = Uri.parse('/zones/${state}');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<List<MptZone>, MptZone>($request);
  }

  @override
  Future<Response<MptZoneByGPS>> getZonesByGps(double lat, double long) {
    final Uri $url = Uri.parse('/zones/${lat}/${long}');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<MptZoneByGPS, MptZoneByGPS>($request);
  }
}
