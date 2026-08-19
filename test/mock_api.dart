import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:waktusolat_api_client/waktusolat_api_client.dart';

/// Builds a [WaktuSolatApi] whose requests are answered by [handler] instead of
/// hitting the network, wired with the same converter and services as the real
/// client.
WaktuSolatApi mockApi(MockClientHandler handler) => WaktuSolatApi.withClient(
  ChopperClient(
    baseUrl: WaktuSolatApi.defaultBaseUrl,
    client: MockClient(handler),
    converter: WaktuSolatApi.converter,
    errorConverter: const JsonConverter(),
    services: WaktuSolatApi.createServices(),
  ),
);

/// Answers every request with [body] and [statusCode], recording the request
/// that was made in [captured].
MockClientHandler jsonResponse(
  String body, {
  int statusCode = 200,
  List<http.Request>? captured,
}) => (request) async {
  captured?.add(request);

  return http.Response(
    body,
    statusCode,
    headers: {'content-type': 'application/json'},
  );
};
