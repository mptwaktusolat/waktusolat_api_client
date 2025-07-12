# Waktu Solat API Client

A Dart package for fetching prayer times from the Waktu Solat API (https://api.waktusolat.app). This package provides easy-to-use methods to retrieve prayer times for different zones in Malaysia.

## Usage

### Basic Usage

```dart
import 'package:waktusolat_api_client/waktusolat_api_client.dart';

void main() async {
  try {
    // Get prayer times for a zone in Malaysia (e.g., SGR01)
    final waktuSolat = await WaktuSolat.getWaktuSolatV2('SGR01');

    print('Zone: ${waktuSolat.zone}');
    print('Month: ${waktuSolat.month} ${waktuSolat.year}');
    print('Number of prayer days: ${waktuSolat.prayers.length}');

    // Get first day prayer times
    final firstDay = waktuSolat.prayers.first;
    print('Day ${firstDay.day} prayer times:');
    print('Hijri Date: ${firstDay.hijri}');
    print('Fajr: ${firstDay.fajrTime}');
    print('Syuruk: ${firstDay.syurukTime}');
    print('Dhuhr: ${firstDay.dhuhrTime}');
    print('Asr: ${firstDay.asrTime}');
    print('Maghrib: ${firstDay.maghribTime}');
    print('Isha: ${firstDay.ishaTime}');

  } catch (e) {
    print('Error: $e');
  }
}
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
