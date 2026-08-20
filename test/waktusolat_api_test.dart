import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:waktusolat_api_client/waktusolat_api_client.dart';

import 'mock_api.dart';

const _zonesJson =
    '[{"jakimCode":"PRK01","negeri":"Perak","daerah":"Tapah, Slim River"}]';

void main() {
  group('WaktuSolat', () {
    tearDown(WaktuSolat.dispose);

    test('api returns the same lazily created instance', () {
      expect(WaktuSolat.api, same(WaktuSolat.api));
    });

    test('the api setter replaces the shared instance', () async {
      WaktuSolat.api = mockApi(jsonResponse(_zonesJson));

      final zones = await WaktuSolat.api.zones.getAllZones();

      expect(zones.single.jakimCode, 'PRK01');
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

    test('a custom baseUrl is used for requests', () async {
      final requests = <http.Request>[];
      final api = WaktuSolatApi.withClient(
        ChopperClient(
          baseUrl: Uri.parse('https://staging.example'),
          client: MockClient(jsonResponse(_zonesJson, captured: requests)),
          converter: WaktuSolatApi.converter,
          errorConverter: WaktuSolatApi.errorConverter,
          services: WaktuSolatApi.createServices(),
        ),
      );

      await api.zones.getAllZones();

      expect(requests.single.url.origin, 'https://staging.example');

      api.dispose();
    });
  });
}
