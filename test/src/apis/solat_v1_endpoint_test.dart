import 'package:test/test.dart';
import 'package:waktusolat_api_client/waktusolat_api_client.dart';

void main() {
  group('SolatV1Endpoint', () {
    late WaktuSolatApi api;

    setUp(() => api = WaktuSolatApi());
    tearDown(() => api.dispose());

    test('Test valid get monthly prayer time', () async {
      final month = await api.solatV1.getMonthlyPrayerTime(
        'SGR01',
        year: 2026,
        month: 8,
      );

      expect(month, isA<MptSolatV1Month>());
      expect(month.zone, 'SGR01');
      expect(month.prayerTimes.length, inInclusiveRange(28, 31));

      final first = month.prayerTimes.first;
      expect(first.hijri, isA<HijriDate>());
      expect(first.hijri.year, 1448);
      expect(first.date, '01-Aug-2026');
      expect(first.imsak, matches(RegExp(r'^\d{2}:\d{2}:\d{2}$')));
      expect(first.fajr, matches(RegExp(r'^\d{2}:\d{2}:\d{2}$')));
      expect(first.syuruk, matches(RegExp(r'^\d{2}:\d{2}:\d{2}$')));
      expect(first.dhuha, matches(RegExp(r'^\d{2}:\d{2}:\d{2}$')));
      expect(first.dhuhr, matches(RegExp(r'^\d{2}:\d{2}:\d{2}$')));
      expect(first.asr, matches(RegExp(r'^\d{2}:\d{2}:\d{2}$')));
      expect(first.maghrib, matches(RegExp(r'^\d{2}:\d{2}:\d{2}$')));
      expect(first.isha, matches(RegExp(r'^\d{2}:\d{2}:\d{2}$')));
    });

    test(
      'Test valid get monthly prayer times without year and month',
      () async {
        final month = await api.solatV1.getMonthlyPrayerTime('SGR01');

        expect(month.zone, 'SGR01');
        expect(month.prayerTimes, isNotEmpty);
      },
    );

    test('Test valid get daily prayer time', () async {
      final day = await api.solatV1.getDailyPrayerTime('SGR01', 1);

      expect(day, isA<MptSolatV1Day>());
      expect(day.periodType, 'day');
      expect(day.zone, 'SGR01');
      expect(day.prayerTimes.hijri, isA<HijriDate>());
      expect(day.prayerTimes.imsak, isNotEmpty);
      expect(day.prayerTimes.fajr, isNotEmpty);
      expect(day.prayerTimes.syuruk, isNotEmpty);
      expect(day.prayerTimes.dhuha, isNotEmpty);
      expect(day.prayerTimes.dhuhr, isNotEmpty);
      expect(day.prayerTimes.asr, isNotEmpty);
      expect(day.prayerTimes.maghrib, isNotEmpty);
      expect(day.prayerTimes.isha, isNotEmpty);
    });
  });
}
