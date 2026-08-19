import 'package:http/http.dart' as http;
import 'package:test/test.dart';
import 'package:waktusolat_api_client/waktusolat_api_client.dart';

import '../../mock_api.dart';

const _prayerTime = '''
{"hijri":"1448-02-17","date":"01-Aug-2026","day":"Saturday",
 "imsak":"05:51:00","fajr":"06:01:00","syuruk":"07:11:00","dhuha":"07:36:00",
 "dhuhr":"13:22:00","asr":"16:43:00","maghrib":"19:30:00","isha":"20:42:00"}
''';

const _monthJson =
    '{"prayerTime":[$_prayerTime],"status":"OK!","serverTime":"2026-08-18 21:31:27",'
    '"periodType":"duration","lang":"","zone":"SGR01","bearing":""}';

const _dayJson =
    '{"prayerTime":$_prayerTime,"status":"OK!","serverTime":"2026-08-18 21:31:27",'
    '"periodType":"day","lang":"","zone":"SGR01","bearing":""}';

void main() {
  group('SolatV1Endpoint', () {
    test('getMonthlyPrayerTime decodes a list of prayer times', () async {
      final requests = <http.Request>[];
      final api = mockApi(jsonResponse(_monthJson, captured: requests));

      final response = await api.solatV1.getMonthlyPrayerTime(
        'SGR01',
        year: 2026,
        month: 8,
      );

      final request = requests.single;
      expect(request.url.path, '/solat/SGR01');
      expect(request.url.queryParameters, {'year': '2026', 'month': '8'});

      expect(response.body, isA<MptSolatV1Month>());
      expect(response.body!.prayerTimes, hasLength(1));
      expect(response.body!.zone, 'SGR01');
    });

    test('getDailyPrayerTime decodes a single prayer time', () async {
      final requests = <http.Request>[];
      final api = mockApi(jsonResponse(_dayJson, captured: requests));

      final response = await api.solatV1.getDailyPrayerTime('SGR01', 1);

      expect(requests.single.url.path, '/solat/SGR01/1');
      expect(response.body, isA<MptSolatV1Day>());
      expect(response.body!.periodType, 'day');
    });

    test('prayer times carry the API imsak and dhuha values', () async {
      final api = mockApi(jsonResponse(_dayJson));

      final prayerTime = (await api.solatV1.getDailyPrayerTime(
        'SGR01',
        1,
      )).body!.prayerTimes;

      expect(prayerTime.imsak, '05:51:00');
      expect(prayerTime.dhuha, '07:36:00');
    });
  });
}
