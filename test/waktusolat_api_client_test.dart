import 'package:http/http.dart' as http;
import 'package:test/test.dart';
import 'package:waktusolat_api_client/waktusolat_api_client.dart';

import 'mock_api.dart';

const _waktuSolatJson = '''
{"zone":"SGR01","year":2026,"month":"AUG","month_number":8,"last_updated":null,
 "prayers":[{"day":1,"hijri":"1448-02-17",
   "imsak":1785534660,"fajr":1785535260,"syuruk":1785539460,"dhuha":1785540960,
   "dhuhr":1785561720,"asr":1785573780,"maghrib":1785583800,"isha":1785588120}]}
''';

const _zonesJson =
    '[{"jakimCode":"PRK01","negeri":"Perak","daerah":"Tapah, Slim River"}]';

const _notFoundJson = '{"message":"No data found for zone: INVALID"}';

void main() {
  group('WaktuSolat', () {
    tearDown(() => WaktuSolat.api = WaktuSolatApi());

    test('getWaktuSolatV2 returns valid data for SGR01', () async {
      WaktuSolat.api = mockApi(jsonResponse(_waktuSolatJson));

      final result = await WaktuSolat.getWaktuSolatV2('SGR01');

      expect(result.zone, equals('SGR01'));
      expect(result.year, isA<int>());
      expect(result.month, isA<String>());
      expect(result.monthNumber, isA<int>());
      expect(result.prayers, isNotEmpty);

      // Check first prayer data
      final firstPrayer = result.prayers.first;
      expect(firstPrayer.day, isA<int>());
      expect(firstPrayer.hijri, isA<HijriDate>());
      expect(firstPrayer.imsak, isA<DateTime>());
      expect(firstPrayer.fajr, isA<DateTime>());
      expect(firstPrayer.syuruk, isA<DateTime>());
      expect(firstPrayer.dhuha, isA<DateTime>());
      expect(firstPrayer.dhuhr, isA<DateTime>());
      expect(firstPrayer.asr, isA<DateTime>());
      expect(firstPrayer.maghrib, isA<DateTime>());
      expect(firstPrayer.isha, isA<DateTime>());
    });

    test('getWaktuSolatV2 defaults to the current month', () async {
      final requests = <http.Request>[];
      WaktuSolat.api = mockApi(
        jsonResponse(_waktuSolatJson, captured: requests),
      );

      await WaktuSolat.getWaktuSolatV2('SGR01');

      final now = DateTime.now();
      expect(requests.single.url.queryParameters, {
        'year': '${now.year}',
        'month': '${now.month}',
      });
    });

    test('getAllZones returns the decoded list', () async {
      WaktuSolat.api = mockApi(jsonResponse(_zonesJson));

      final zones = await WaktuSolat.getAllZones();

      expect(zones, isA<List<MptZone>>());
      expect(zones.single.jakimCode, 'PRK01');
    });

    test('getWaktuSolatV2 throws for an invalid zone code', () async {
      WaktuSolat.api = mockApi(jsonResponse(_notFoundJson, statusCode: 404));

      await expectLater(
        WaktuSolat.getWaktuSolatV2('INVALID'),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('Failed to load prayer times. Status code: 404'),
          ),
        ),
      );
    });

    test('getJadualSolatDownloadUrl builds the PDF url', () {
      expect(
        WaktuSolat.getJadualSolatDownloadUrl('SGR01', year: 2026, month: 8),
        'https://api.waktusolat.app/jadual_solat/SGR01?year=2026&month=8',
      );
    });
  });
}
