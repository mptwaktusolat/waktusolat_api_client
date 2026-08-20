import 'package:chopper/chopper.dart';
import 'package:waktusolat_api_client/src/apis/chrono_endpoint.dart';
import 'package:waktusolat_api_client/src/apis/jadual_solat_endpoint.dart';
import 'package:waktusolat_api_client/src/apis/solat_v1_endpoint.dart';
import 'package:waktusolat_api_client/src/apis/solat_v2_endpoint.dart';
import 'package:waktusolat_api_client/src/apis/zones_endpoint.dart';
import 'package:waktusolat_api_client/src/converters/json_serializable_converter.dart';

/// Zero-setup entry point: a lazily created, replaceable [WaktuSolatApi].
///
/// ```dart
/// final solat = await WaktuSolat.api.solatV2.getPrayerTimeByZone('SGR01');
/// ```
class WaktuSolat {
  WaktuSolat._();

  static WaktuSolatApi? _api;

  /// The shared API instance, created on first access.
  static WaktuSolatApi get api => _api ??= WaktuSolatApi();

  /// Replaces the shared instance — point the package at another host, or
  /// inject a mock transport in tests.
  static set api(WaktuSolatApi value) => _api = value;

  /// Disposes the shared instance; the next access to [api] builds a fresh one.
  static void dispose() {
    _api?.dispose();
    _api = null;
  }
}

/// A Waktu Solat API client, exposing one [ChopperService] per endpoint group.
class WaktuSolatApi {
  /// The public Waktu Solat API host.
  static final Uri defaultBaseUrl = Uri.parse('https://api.waktusolat.app');

  /// Creates an API instance with default base URL
  WaktuSolatApi({Uri? baseUrl})
    : _client = ChopperClient(
        baseUrl: baseUrl ?? defaultBaseUrl,
        converter: converter,
        errorConverter: errorConverter,
        services: createServices(),
      );

  WaktuSolatApi.withClient(this._client);

  static Converter get converter =>
      JsonSerializableConverter(waktuSolatJsonFactories);

  static ErrorConverter get errorConverter => const JsonConverter();

  static Iterable<ChopperService> createServices() => [
    ChronoEndpoint.create(),
    SolatV1Endpoint.create(),
    SolatV2Endpoint.create(),
    ZonesEndpoint.create(),
    JadualSolatEndpoint.create(),
  ];

  final ChopperClient _client;

  ChopperClient get client => _client;

  ChronoEndpoint get chrono => _client.getService<ChronoEndpoint>();

  SolatV1Endpoint get solatV1 => _client.getService<SolatV1Endpoint>();

  SolatV2Endpoint get solatV2 => _client.getService<SolatV2Endpoint>();

  ZonesEndpoint get zones => _client.getService<ZonesEndpoint>();

  JadualSolatEndpoint get jadualSolat =>
      _client.getService<JadualSolatEndpoint>();

  void dispose() => _client.dispose();
}
