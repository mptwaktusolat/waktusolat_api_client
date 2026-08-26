import 'package:test/test.dart';
import 'package:waktusolat_api_client/waktusolat_api_client.dart';

void main() {
  group('ZonesEndpoint', () {
    late WaktuSolatApi api;

    setUp(() => api = WaktuSolatApi());
    tearDown(() => api.dispose());

    test('Test valid get all zones', () async {
      final zones = await api.zones.getAllZones();

      expect(zones, isA<List<MptZone>>());
      expect(zones, hasLength(60));
      expect(zones.first.jakimCode, isNotEmpty);
      expect(zones.first.negeri, isNotEmpty);
      expect(zones.first.daerah, isNotEmpty);
    });

    test('Test valid get current state zones', () async {
      final zones = await api.zones.getZonesByState('PRK');

      expect(zones, isNotEmpty);
      expect(zones.map((z) => z.negeri), everyElement('Perak'));
    });

    test('Test valid get prayer zone by GPS', () async {
      // KL
      final zone1 = await api.zones.getZonesByGps(3.189, 101.672);

      expect(zone1.zone, 'WLY01');
      expect(zone1.state, 'KUL');
      expect(zone1.district, 'W.P. Kuala Lumpur');

      // nenek
      final zone2 = await api.zones.getZonesByGps(3.182, 102.277);

      expect(zone2.zone, 'PHG04');
      expect(zone2.state, 'PHG');
      expect(zone2.district, 'Bentong');

      // kelantan
      final zone3 = await api.zones.getZonesByGps(5.175, 101.822);

      expect(zone3.zone, 'KTN02');
      expect(zone3.state, 'KTN');
      expect(zone3.district, 'Gua Musang');
    });
  });
}
