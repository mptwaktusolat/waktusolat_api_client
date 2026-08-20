// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'jadual_solat_endpoint.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$JadualSolatEndpoint extends JadualSolatEndpoint {
  _$JadualSolatEndpoint([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = JadualSolatEndpoint;

  @override
  Future<Uint8List> getJadualSolat(String zone, {int? year, int? month}) async {
    final Uri $url = Uri.parse('/jadual_solat/${zone}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'year': year,
      'month': month,
    };
    final Map<String, String> $headers = {'Accept': 'application/pdf'};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    final Response $response = await client.send<Uint8List, Uint8List>(
      $request,
      responseConverter: JadualSolatEndpoint.pdfConverter,
    );
    return $response.bodyOrThrow;
  }
}
