import 'package:test/test.dart';
import 'package:waktusolat_api_client/waktusolat_api_client.dart';

void main() {
  group('HijriDate', () {
    test('parses a valid Hijri date string', () {
      final date = HijriDate.parse('1448-02-17');

      expect(date.year, 1448);
      expect(date.month, 2);
      expect(date.day, 17);
      expect(date.monthName, 'Safar');
      expect(date.shortMonthName, 'Saf');
      expect(date.toJson(), '1448-02-17');
      expect(date.dMY(), '17 Saf 1448');
      expect(date.dM(), '17 Saf');
      expect(date.dMMM(), '17 Safar');
      expect(date.toString(), '17 Safar 1448');
    });

    test('test invalid Hijri month', () {
      expect(
        () => HijriDate.parse('1448-13-17'),
        throwsA(isA<RangeError>()),
      );
    });

    test('test fromJson valid', () {
      final parsed = HijriDate.parse('1448-02-17');
      final fromJson = HijriDate.fromJson('1448-02-17');

      expect(fromJson, equals(parsed));
      expect(fromJson.toJson(), '1448-02-17');
    });

    test('test valid compare equality', () {
      final first = HijriDate(1448, 2, 17);
      final second = HijriDate.parse('1448-02-17');
      final different = HijriDate(1448, 2, 18);

      expect(first, equals(second));
      expect(first.hashCode, equals(second.hashCode));
      expect(first, isNot(equals(different)));
      expect(first == second, isTrue);
      expect(first == different, isFalse);
    });
  });
}
