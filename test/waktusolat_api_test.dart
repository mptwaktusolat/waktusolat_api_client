import 'package:test/test.dart';
import 'package:waktusolat_api_client/waktusolat_api_client.dart';

void main() {
  group('WaktuSolat', () {
    tearDown(WaktuSolat.dispose);

    test('api returns the same created instance', () {
      expect(WaktuSolat.api, same(WaktuSolat.api));
    });

    test('Test API endpoint is reachable', () async {
      final zones = await WaktuSolat.api.zones.getAllZones();

      expect(zones, isNotEmpty);
      expect(zones.first.jakimCode, isNotEmpty);
    });

    test('dispose clears the shared instance', () {
      final first = WaktuSolat.api;

      WaktuSolat.dispose();

      expect(WaktuSolat.api, isNot(same(first)));
    });
  });

  group('WaktuSolatApi', () {
    test('exposes every registered service', () {
      final api = WaktuSolatApi();

      expect(api.chrono, isA<ChronoEndpoint>());
      expect(api.solatV1, isA<SolatV1Endpoint>());
      expect(api.solatV2, isA<SolatV2Endpoint>());
      expect(api.zones, isA<ZonesEndpoint>());
      expect(api.jadualSolat, isA<JadualSolatEndpoint>());

      api.dispose();
    });

    test('defaults to the public library user agent', () async {
      final api = WaktuSolatApi();

      expect(api.chrono, isA<ChronoEndpoint>());
      expect(WaktuSolatApi.userAgent, WaktuSolatApi.defaultUserAgent);
      expect(
        WaktuSolatApi.userAgent,
        equals('waktusolat.app-library/2.0.0'),
      );

      api.dispose();
    });

    test('setUserAgent overrides the header sent with requests', () async {
      WaktuSolatApi.setUserAgent('my-app/1.0.0');

      // The shared instance picks the new User-Agent up on its next request.
      final zones = await WaktuSolat.api.zones.getAllZones();

      expect(zones, isNotEmpty);
      expect(WaktuSolatApi.userAgent, 'my-app/1.0.0');
    });
  });
}
