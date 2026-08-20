import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:test/test.dart';
import 'package:waktusolat_api_client/waktusolat_api_client.dart';

import '../../mock_api.dart';

/// A minimal PDF: the `%PDF-1.4` magic number, a byte that is invalid UTF-8
/// (0xFF), and a NUL. If anything tries to decode this as text, it will not
/// survive the round trip intact.
final _pdfBytes = Uint8List.fromList([
  ...'%PDF-1.4\n'.codeUnits,
  0xFF,
  0x00,
  0xC3,
  0x28,
  ...'\n%%EOF'.codeUnits,
]);

void main() {
  group('JadualSolatEndpoint', () {
    test('getJadualSolat returns the PDF bytes unchanged', () async {
      final requests = <http.Request>[];
      final api = mockApi(bytesResponse(_pdfBytes, captured: requests));

      final pdf = await api.jadualSolat.getJadualSolat(
        'SGR01',
        year: 2026,
        month: 8,
      );

      final request = requests.single;
      expect(request.url.path, '/jadual_solat/SGR01');
      expect(request.url.queryParameters, {'year': '2026', 'month': '8'});

      expect(pdf, isA<Uint8List>());
      expect(pdf, equals(_pdfBytes));
    });

    test('the response is not mangled by the JSON converter', () async {
      final api = mockApi(bytesResponse(_pdfBytes));

      final pdf = await api.jadualSolat.getJadualSolat('SGR01');

      // The bytes that a UTF-8 or JSON decode would have destroyed.
      expect(pdf.sublist(0, 8), '%PDF-1.4'.codeUnits);
      expect(pdf, contains(0xFF));
      expect(pdf, contains(0x00));
      expect(pdf.length, _pdfBytes.length);
    });

    test('asks the server for a PDF', () async {
      final requests = <http.Request>[];
      final api = mockApi(bytesResponse(_pdfBytes, captured: requests));

      await api.jadualSolat.getJadualSolat('SGR01');

      expect(requests.single.headers['Accept'], 'application/pdf');
    });

    test('omits year and month when not given', () async {
      final requests = <http.Request>[];
      final api = mockApi(bytesResponse(_pdfBytes, captured: requests));

      await api.jadualSolat.getJadualSolat('SGR01');

      expect(requests.single.url.queryParameters, isEmpty);
    });

    test('a failed download throws ChopperHttpException', () async {
      final api = mockApi(
        jsonResponse('{"message":"not found"}', statusCode: 404),
      );

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
