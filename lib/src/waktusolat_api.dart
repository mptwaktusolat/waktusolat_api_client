import 'package:chopper/chopper.dart';
import 'package:waktusolat_api_client/src/apis/chrono_endpoint.dart';
import 'package:waktusolat_api_client/src/apis/solat_v1_endpoint.dart';
import 'package:waktusolat_api_client/src/apis/solat_v2_endpoint.dart';
import 'package:waktusolat_api_client/src/apis/zones_endpoint.dart';
import 'package:waktusolat_api_client/src/converters/json_serializable_converter.dart';

class WaktuSolatApi {
  /// The public Waktu Solat API host.
  static final Uri defaultBaseUrl = Uri.parse('https://api.waktusolat.app');

  /// Creates an API instance with default base URL
  WaktuSolatApi({Uri? baseUrl})
    : _client = ChopperClient(
        baseUrl: baseUrl ?? defaultBaseUrl,
        converter: converter,
        errorConverter: const JsonConverter(),
        services: createServices(),
      );

  WaktuSolatApi.withClient(this._client);

  static Converter get converter =>
      JsonSerializableConverter(waktuSolatJsonFactories);

  static Iterable<ChopperService> createServices() => [
    ChronoEndpoint.create(),
    SolatV1Endpoint.create(),
    SolatV2Endpoint.create(),
    ZonesEndpoint.create(),
  ];

  final ChopperClient _client;

  ChopperClient get client => _client;

  ChronoEndpoint get chrono => _client.getService<ChronoEndpoint>();

  SolatV1Endpoint get solatV1 => _client.getService<SolatV1Endpoint>();

  SolatV2Endpoint get solatV2 => _client.getService<SolatV2Endpoint>();

  ZonesEndpoint get zones => _client.getService<ZonesEndpoint>();

  void dispose() => _client.dispose();
}
