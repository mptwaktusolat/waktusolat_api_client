import 'package:test/test.dart';
import 'package:waktusolat_api_client/waktusolat_api_client.dart';

void main() {
  group('SolatV2Endpoint', () {
    late WaktuSolatApi api;

    setUp(() => api = WaktuSolatApi());
    tearDown(() => api.dispose());

    test('Test valid get prayer time by zone', () async {
      final solat = await api.solatV2.getPrayerTimeByZone(
        'SGR01',
        year: 2026,
        month: 8,
      );

      expect(solat.zone, 'SGR01');
      expect(solat.year, 2026);
      expect(solat.month, 'AUG');
      expect(solat.monthNumber, 8);
      expect(solat.prayers.length, inInclusiveRange(28, 31));

      final firstDayDate = DateTime(2026, 8, 1);

      final prayer = solat.prayers.first;
      expect(prayer.day, 1);
      expect(prayer.hijri, isA<HijriDate>());
      expect(prayer.hijri.year, 1448);
      expect(prayer.imsak.isAfter(firstDayDate), isTrue);
      expect(prayer.fajr.isAfter(firstDayDate), isTrue);
      expect(prayer.syuruk.isAfter(firstDayDate), isTrue);
      expect(prayer.dhuha.isAfter(firstDayDate), isTrue);
      expect(prayer.dhuhr.isAfter(firstDayDate), isTrue);
      expect(prayer.asr.isAfter(firstDayDate), isTrue);
      expect(prayer.maghrib.isAfter(firstDayDate), isTrue);
      expect(prayer.isha.isAfter(firstDayDate), isTrue);
    });

    test('Test valid get prayer times without specify year & month', () async {
      final solat = await api.solatV2.getPrayerTimeByZone('SGR01');

      expect(solat.zone, 'SGR01');
      expect(solat.prayers, isNotEmpty);
    });

    test('Test valid get prayer time from coordinate', () async {
      final solat = await api.solatV2.getPrayerTimeByGps(3.1, 101.6);

      expect(solat.zone, 'SGR01');
      expect(solat.prayers, isNotEmpty);
    });

    test('Test invalid get prayer time with invalid zone code', () async {
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
