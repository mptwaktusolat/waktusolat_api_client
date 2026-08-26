import 'package:test/test.dart';
import 'package:waktusolat_api_client/waktusolat_api_client.dart';

void main() {
  group('ChronoEndpoint', () {
    late WaktuSolatApi api;

    setUp(() => api = WaktuSolatApi());
    tearDown(() => api.dispose());

    test('Test valid get Chrono', () async {
      final chrono = await api.chrono.getChrono();

      expect(chrono.dayOfMonth, greaterThan(0));
      expect(chrono.dayOfMonth, lessThanOrEqualTo(31));
      expect(chrono.dayOfWeek, inInclusiveRange(0, 6));
      expect(chrono.time24, matches(RegExp(r'^\d{2}:\d{2}:\d{2}$')));
      expect(chrono.timezone, 'Asia/Kuala_Lumpur');
    });
  });
}
