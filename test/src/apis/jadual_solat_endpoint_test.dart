import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:waktusolat_api_client/waktusolat_api_client.dart';

void main() {
  group('JadualSolatEndpoint', () {
    late WaktuSolatApi api;

    setUp(() => api = WaktuSolatApi());
    tearDown(() => api.dispose());

    test('Test valid get PDF', () async {
      final pdf = await api.jadualSolat.getJadualSolat(
        'SGR01',
        year: 2026,
        month: 8,
      );

      expect(pdf, isA<Uint8List>());
      expect(pdf.sublist(0, 5), '%PDF-'.codeUnits);
      expect(pdf.length, greaterThan(1000));
    });

    test('Test valid get PDF when year and month is not given', () async {
      final pdf = await api.jadualSolat.getJadualSolat('SGR01');

      expect(pdf.sublist(0, 5), '%PDF-'.codeUnits);
    });

    test('Test Invalid get PDF with invalid zone code', () async {
      await expectLater(
        api.jadualSolat.getJadualSolat('INVALID'),
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
