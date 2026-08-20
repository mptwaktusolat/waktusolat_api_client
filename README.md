# Waktu Solat API Client

A Dart package for fetching prayer times from the Waktu Solat API (https://api.waktusolat.app). This package provides easy-to-use methods to retrieve prayer times for different zones in Malaysia.

## Usage

Every endpoint is reached through a service on a `WaktuSolatApi`. `WaktuSolat.api` is a shared
instance created on first use, so there is nothing to set up:

```dart
import 'package:waktusolat_api_client/waktusolat_api_client.dart';

void main() async {
  try {
    // Get prayer times for a zone in Malaysia (e.g., SGR01)
    final waktuSolat = await WaktuSolat.api.solatV2.getPrayerTimeByZone('SGR01');

    print('Zone: ${waktuSolat.zone}');
    print('Month: ${waktuSolat.month} ${waktuSolat.year}');
    print('Number of prayer days: ${waktuSolat.prayers.length}');

    // Get first day prayer times
    final firstDay = waktuSolat.prayers.first;
    print('Day ${firstDay.day} prayer times:');
    print('Hijri Date: ${firstDay.hijri}');
    print('Imsak: ${firstDay.imsak}');
    print('Fajr: ${firstDay.fajr}');
    print('Syuruk: ${firstDay.syuruk}');
    print('Dhuha: ${firstDay.dhuha}');
    print('Dhuhr: ${firstDay.dhuhr}');
    print('Asr: ${firstDay.asr}');
    print('Maghrib: ${firstDay.maghrib}');
    print('Isha: ${firstDay.isha}');
  } on ChopperHttpException catch (e) {
    print('Request failed with ${e.response.statusCode}');
  }
}
```

### The services

| Service | Method | Returns |
| --- | --- | --- |
| `solatV2` | `getPrayerTimeByZone(zone, {year, month})` | `MPTWaktuSolatV2` |
| `solatV2` | `getPrayerTimeByGps(lat, long, {year, month})` | `MPTWaktuSolatV2` |
| `solatV1` | `getMonthlyPrayerTime(zone, {year, month})` | `MptSolatV1Month` |
| `solatV1` | `getDailyPrayerTime(zone, day, {year, month})` | `MptSolatV1Day` |
| `zones` | `getAllZones()` | `List<MptZone>` |
| `zones` | `getZonesByState(state)` | `List<MptZone>` |
| `zones` | `getZonesByGps(lat, long)` | `MptZoneByGPS` |
| `chrono` | `getChrono()` | `Chrono` |
| `jadualSolat` | `getJadualSolat(zone, {year, month})` | `Uint8List` (PDF bytes) |

```dart
// Version 1 prayer times
final month = await WaktuSolat.api.solatV1.getMonthlyPrayerTime('SGR01');
final day = await WaktuSolat.api.solatV1.getDailyPrayerTime('SGR01', 1);

// Prayer times by coordinates
final byGps = await WaktuSolat.api.solatV2.getPrayerTimeByGps(3.1, 101.6);

// Zones
final allZones = await WaktuSolat.api.zones.getAllZones();
final perakZones = await WaktuSolat.api.zones.getZonesByState('PRK');
final zone = await WaktuSolat.api.zones.getZonesByGps(3.1, 101.6);

// Server date and time
final chrono = await WaktuSolat.api.chrono.getChrono();

// The JAKIM prayer timetable, as PDF bytes
final pdf = await WaktuSolat.api.jadualSolat.getJadualSolat('SGR01');
```

`year` and `month` are optional everywhere they appear — omit them and the API returns the current
month.

### Downloading the timetable PDF

`jadualSolat` is the one endpoint that does not return JSON. It answers with `application/pdf`, so
it hands back the raw bytes for you to save or render:

```dart
final pdf = await WaktuSolat.api.jadualSolat.getJadualSolat('SGR01');

await File('jadual_solat.pdf').writeAsBytes(pdf);
```

The bytes come through untouched — the endpoint opts out of the JSON converter with a
`@FactoryConverter`, so nothing tries to parse the PDF as text.

### Error handling

A method returns the decoded model on success. Anything else — a non-2xx status, or a successful
response with an empty body — throws `ChopperHttpException`, which carries the whole response:

```dart
try {
  await WaktuSolat.api.solatV2.getPrayerTimeByZone('INVALID');
} on ChopperHttpException catch (e) {
  print(e.response.statusCode); // 404
  print(e.response.error);      // the decoded error body
  print(e.response.headers);
}
```

### Managing the client

`WaktuSolat.api` is a convenience, not a requirement. Build and own a `WaktuSolatApi` yourself when
you need more than one, or a different host:

```dart
final api = WaktuSolatApi();
final api = WaktuSolatApi(baseUrl: Uri.parse('https://staging.example'));

await api.solatV2.getPrayerTimeByZone('SGR01');
api.dispose();
```

You can also point the shared instance at it with `WaktuSolat.api = ...`, and release it later with
`WaktuSolat.dispose()`.

To supply your own transport — an `http.Client` with custom timeouts, or a mock in tests — build the
`ChopperClient` yourself and pass it to `WaktuSolatApi.withClient`, reusing `WaktuSolatApi.converter`
and `WaktuSolatApi.createServices()`:

```dart
final api = WaktuSolatApi.withClient(
  ChopperClient(
    baseUrl: WaktuSolatApi.defaultBaseUrl,
    client: myHttpClient,
    converter: WaktuSolatApi.converter,
    errorConverter: WaktuSolatApi.errorConverter,
    services: WaktuSolatApi.createServices(),
  ),
);
```

### Hijri Date Support

The package includes full support for Hijri dates:

```dart
final prayer = waktuSolat.prayers.first;
final hijriDate = prayer.hijri;

print(hijriDate.toString()); // "4 Zulhijjah 1446"
print(hijriDate.dMY()); // "4 Zhj 1446"
print(hijriDate.dM()); // "4 Zhj"
print(hijriDate.dMMM()); // "4 Zulhijjah"
```

### Zone Codes

This package works with JAKIM zone codes for Malaysia only. Some examples:

- `JHR01` - Pulau Aur dan Pulau Pemanggil, Johor
- `JHR02` - Johor Bahru, Kota Tinggi, Mersing, Kulai
- `KUL01` - Kuala Lumpur, Putrajaya
- `SGR01` - Gombak, Petaling, Sepang, Hulu Langat, Hulu Selangor, Shah Alam, Selangor
- `KDH01` - Kota Setar, Kubang Pasu, Pokok Sena (Daerah Kecil), Kedah

For a complete list of zone codes, refer to the [e-solat JAKIM](https://www.e-solat.gov.my/).

## API Reference

See https://api.waktusolat.app/docs.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
