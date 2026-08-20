import 'package:http/http.dart' as http;
import 'package:test/test.dart';
import 'package:waktusolat_api_client/waktusolat_api_client.dart';

import '../../mock_api.dart';

const _chronoJson = '''
{
  "date":"18-08-2026",
  "day_of_month":18,
  "day_of_week":2,
  "time12":"09:31:27 PM",
  "time24":"21:31:27",
  "unix":1787059887,
  "iso8601":"2026-08-18T21:31:27+08:00",
  "timezone":"Asia/Kuala_Lumpur"
}
''';

void main() {
  group('ChronoEndpoint', () {
    test('getChrono maps the snake_case day fields', () async {
      final requests = <http.Request>[];
      final api = mockApi(jsonResponse(_chronoJson, captured: requests));

      final chrono = await api.chrono.getChrono();

      expect(requests.single.url.path, '/chrono');
      expect(chrono, isA<Chrono>());
      expect(chrono.dayOfMonth, 18);
      expect(chrono.dayOfWeek, 2);
      expect(chrono.time24, '21:31:27');
      expect(chrono.unix, 1787059887);
      expect(chrono.timezone, 'Asia/Kuala_Lumpur');
    });
  });
}
