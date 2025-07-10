import 'package:waktusolat_api_client/waktusolat_api_client.dart';
import 'package:test/test.dart';

void main() {
  group('WaktuSolat API Client Tests', () {
    test('getWaktuSolatV2 should return valid data for SGR01', () async {
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
      expect(firstPrayer.fajr, isA<int>());
      expect(firstPrayer.syuruk, isA<int>());
      expect(firstPrayer.dhuhr, isA<int>());
      expect(firstPrayer.asr, isA<int>());
      expect(firstPrayer.maghrib, isA<int>());
      expect(firstPrayer.isha, isA<int>());
    });

    test(
      'getWaktuSolatV2 should throw exception for invalid zone code',
      () async {
        expect(
          () async => await WaktuSolat.getWaktuSolatV2('INVALID'),
          throwsException,
        );
      },
    );
  });
}
