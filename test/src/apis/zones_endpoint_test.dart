import 'package:http/http.dart' as http;
import 'package:test/test.dart';
import 'package:waktusolat_api_client/waktusolat_api_client.dart';

import '../../mock_api.dart';

const _zonesJson = '''
[
  {"jakimCode":"PRK01","negeri":"Perak","daerah":"Tapah, Slim River, Tanjung Malim"},
  {"jakimCode":"PRK02","negeri":"Perak","daerah":"Kuala Kangsar, Sg. Siput, Ipoh"}
]
''';

const _zoneByGpsJson = '{"zone":"SGR01","state":"SGR","district":"Petaling"}';

void main() {
  group('ZonesEndpoint', () {
    test('getAllZones decodes a bare JSON array into List<MptZone>', () async {
      final requests = <http.Request>[];
      final api = mockApi(jsonResponse(_zonesJson, captured: requests));

      final response = await api.zones.getAllZones();

      expect(requests.single.url.path, '/zones');
      expect(response.isSuccessful, isTrue);
      expect(response.body, isA<List<MptZone>>());
      expect(response.body!.map((z) => z.jakimCode), ['PRK01', 'PRK02']);
      expect(response.body!.first.negeri, 'Perak');
    });

    test('getZonesByState puts the state in the path', () async {
      final requests = <http.Request>[];
      final api = mockApi(jsonResponse(_zonesJson, captured: requests));

      final response = await api.zones.getZonesByState('PRK');

      expect(requests.single.url.path, '/zones/PRK');
      expect(response.body, hasLength(2));
    });

    test('getZonesByGps decodes a single object', () async {
      final requests = <http.Request>[];
      final api = mockApi(jsonResponse(_zoneByGpsJson, captured: requests));

      final response = await api.zones.getZonesByGps(3.1, 101.6);

      expect(requests.single.url.path, '/zones/3.1/101.6');
      expect(response.body, isA<MptZoneByGPS>());
      expect(response.body!.zone, 'SGR01');
      expect(response.body!.district, 'Petaling');
    });
  });
}
