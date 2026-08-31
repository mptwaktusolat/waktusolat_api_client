import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:waktusolat_api_client/src/apis/chrono_endpoint.dart';
import 'package:waktusolat_api_client/src/apis/jadual_solat_endpoint.dart';
import 'package:waktusolat_api_client/src/apis/solat_v1_endpoint.dart';
import 'package:waktusolat_api_client/src/apis/solat_v2_endpoint.dart';
import 'package:waktusolat_api_client/src/apis/zones_endpoint.dart';
import 'package:waktusolat_api_client/src/converters/json_serializable_converter.dart';

/// Library entry point
///
/// ```dart
/// final solat = await WaktuSolat.api.solatV2.getPrayerTimeByZone('SGR01');
/// ```
class WaktuSolat {
  WaktuSolat._();

  static WaktuSolatApi? _api;

  static WaktuSolatApi get api => _api ??= WaktuSolatApi();

  static void dispose() {
    _api?.dispose();
    _api = null;
  }
}

/// A Waktu Solat API client
class WaktuSolatApi {
  /// The public Waktu Solat API host.
  static final Uri defaultBaseUrl = Uri.parse('https://api.waktusolat.app');

  /// The User-Agent sent with every request. Set custom string via [setUserAgent].
  static const String defaultUserAgent = 'waktusolat.app-library/2.0.0';

  static String _userAgent = defaultUserAgent;

  static String get userAgent => _userAgent;

  /// Overrides the User-Agent sent with requests.
  static void setUserAgent(String userAgent) => _userAgent = userAgent;

  /// Creates an API instance with default base URL
  WaktuSolatApi({Uri? baseUrl})
    : _client = ChopperClient(
        baseUrl: baseUrl ?? defaultBaseUrl,
        converter: JsonSerializableConverter(waktuSolatJsonFactories),
        errorConverter: const JsonConverter(),
        interceptors: const [_UserAgentInterceptor()],
        services: [
          ChronoEndpoint.create(),
          SolatV1Endpoint.create(),
          SolatV2Endpoint.create(),
          ZonesEndpoint.create(),
          JadualSolatEndpoint.create(),
        ],
      );

  final ChopperClient _client;

  ChronoEndpoint get chrono => _client.getService<ChronoEndpoint>();

  SolatV1Endpoint get solatV1 => _client.getService<SolatV1Endpoint>();

  SolatV2Endpoint get solatV2 => _client.getService<SolatV2Endpoint>();

  ZonesEndpoint get zones => _client.getService<ZonesEndpoint>();

  JadualSolatEndpoint get jadualSolat =>
      _client.getService<JadualSolatEndpoint>();

  void dispose() => _client.dispose();
}

/// Adds the current [WaktuSolatApi.userAgent] to every request.
class _UserAgentInterceptor implements Interceptor {
  const _UserAgentInterceptor();

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) {
    final request = chain.request;
    return chain.proceed(
      request.copyWith(
        headers: {...request.headers, 'User-Agent': WaktuSolatApi.userAgent},
      ),
    );
  }
}
