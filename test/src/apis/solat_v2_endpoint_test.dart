import 'package:http/http.dart' as http;
import 'package:test/test.dart';
import 'package:waktusolat_api_client/waktusolat_api_client.dart';

import '../../mock_api.dart';

const _waktuSolatJson = '''
{"zone":"SGR01","year":2026,"month":"AUG","month_number":8,"last_updated":null,
 "prayers":[{"day":1,"hijri":"1448-02-17",
   "imsak":1785534660,"fajr":1785535260,"syuruk":1785539460,"dhuha":1785540960,
   "dhuhr":1785561720,"asr":1785573780,"maghrib":1785583800,"isha":1785588120}]}
''';

void main() {
  group('SolatV2Endpoint', () {
    test('getPrayerTimeByZone decodes prayers with epoch times', () async {
      final requests = <http.Request>[];
      final api = mockApi(jsonResponse(_waktuSolatJson, captured: requests));

      final solat = await api.solatV2.getPrayerTimeByZone(
        'SGR01',
        year: 2026,
        month: 8,
      );

      final request = requests.single;
      expect(request.url.path, '/v2/solat/SGR01');
      expect(request.url.queryParameters, {'year': '2026', 'month': '8'});

      expect(solat, isA<MPTWaktuSolatV2>());
      expect(solat.monthNumber, 8);
      expect(solat.lastUpdated, isNull);

      final prayer = solat.prayers.single;
      expect(prayer.day, 1);
      expect(prayer.hijri, isA<HijriDate>());
      expect(
        prayer.fajr,
        DateTime.fromMillisecondsSinceEpoch(1785535260 * 1000),
      );
    });

    test('getPrayerTimeByZone omits year and month when not given', () async {
      final requests = <http.Request>[];
      final api = mockApi(jsonResponse(_waktuSolatJson, captured: requests));

      await api.solatV2.getPrayerTimeByZone('SGR01');

      // The API defaults to the current month server-side, so the client no
      // longer fills these in.
      expect(requests.single.url.queryParameters, isEmpty);
    });

    test('imsak and dhuha come from the API, not from an offset', () async {
      final api = mockApi(jsonResponse(_waktuSolatJson));

      final prayer = (await api.solatV2.getPrayerTimeByZone(
        'SGR01',
      )).prayers.single;

      expect(
        prayer.imsak,
        DateTime.fromMillisecondsSinceEpoch(1785534660 * 1000),
      );
      expect(
        prayer.dhuha,
        DateTime.fromMillisecondsSinceEpoch(1785540960 * 1000),
      );

      // The removed PrayerTimeExtension derived dhuha as syuruk + 28min; the
      // API says 25min here, which is exactly why it is no longer computed.
      expect(
        prayer.dhuha,
        isNot(prayer.syuruk.add(const Duration(minutes: 28))),
      );
    });

    test('getPrayerTimeByGps puts the coordinates in the path', () async {
      final requests = <http.Request>[];
      final api = mockApi(jsonResponse(_waktuSolatJson, captured: requests));

      await api.solatV2.getPrayerTimeByGps(3.1, 101.6);

      expect(requests.single.url.path, '/v2/solat/3.1/101.6');
    });

    test('an unsuccessful response throws ChopperHttpException', () async {
      final api = mockApi(
        jsonResponse('{"message":"not found"}', statusCode: 404),
      );

      await expectLater(
        api.solatV2.getPrayerTimeByZone('INVALID'),
        throwsA(
          isA<ChopperHttpException>().having(
            (e) => e.response.statusCode,
            'statusCode',
            404,
          ),
        ),
      );
    });
  });
}
