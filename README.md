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

This library contains every endpoint in the [Waktu Solat API](https://api.waktusolat.app/docs). More example below:

```dart
// Version 1 prayer times
final month = await WaktuSolat.api.solatV1.getMonthlyPrayerTime('SGR01');
final day = await WaktuSolat.api.solatV1.getDailyPrayerTime('SGR01', 1);

// Prayer times by coordinates
final byGps = await WaktuSolat.api.solatV2.getPrayerTimeByGps(3.1, 101.6);

// Zones
final allZones = await WaktuSolat.api.zones.getAllZones();
final zone = await WaktuSolat.api.zones.getZonesByGps(3.1, 101.6);

// Server date and time
final chrono = await WaktuSolat.api.chrono.getChrono();

// The JAKIM prayer timetable, as PDF bytes
final pdf = await WaktuSolat.api.jadualSolat.getJadualSolat('SGR01');
```

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

Release the shared instance with `WaktuSolat.dispose()`.

### User-Agent

Every request is sent with the default User-Agent
`waktusolat.app api client library 2.0.0`. Override it if you want your app to identify itself:

```dart
WaktuSolatApi.setUserAgent('my-app/1.0.0');

final solat = await WaktuSolat.api.solatV2.getPrayerTimeByZone('SGR01');
```

The new User-Agent applies to clients created from that point on, including the already-created
`WaktuSolat.api`. Read the current value back with `WaktuSolatApi.userAgent`.

### Hijri Date Support

The package includes support for Hijri dates:

```dart
final prayer = waktuSolat.prayers.first;
final hijriDate = prayer.hijri;

print(hijriDate.toString()); // "4 Zulhijjah 1446"
print(hijriDate.dMY()); // "4 Zhj 1446"
print(hijriDate.dM()); // "4 Zhj"
print(hijriDate.dMMM()); // "4 Zulhijjah"
```

### Zone Codes

This package works with JAKIM zone codes for Malaysia only.

For a complete list of zone codes, see https://api.waktusolat.app/zones.

## API Reference

See https://api.waktusolat.app/docs.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the [MIT License](LICENSE).
