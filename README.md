# Waktu Solat API Client

A Dart package for fetching prayer times from the Waktu Solat API (https://api.waktusolat.app). This package provides easy-to-use methods to retrieve prayer times for different zones in Malaysia and Singapore.

## Usage

### Basic Usage

```dart
import 'package:waktusolat_api_client/waktusolat_api_client.dart';

void main() async {
  try {
    // Get prayer times for Singapore (SGR01)
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

### Available Data

The `WaktuSolatV2` object contains:

- `zone`: JAKIM zone code (e.g., 'SGR01')
- `year`: Year of the prayer times
- `month`: Month name (e.g., 'JUN')
- `monthNumber`: Month number (1-12)
- `lastUpdated`: Last update timestamp (optional)
- `prayers`: List of `Prayer` objects for each day

Each `Prayer` object contains:

- `day`: Day of the month
- `hijri`: Hijri date object
- Raw timestamps: `fajr`, `syuruk`, `dhuhr`, `asr`, `maghrib`, `isha`
- Formatted times: `fajrTime`, `syurukTime`, `dhuhrTime`, `asrTime`, `maghribTime`, `ishaTime`

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

This package works with JAKIM zone codes. Some examples:

- `SGR01` - Singapore
- `JHR01` - Pulau Aur dan Pemanggil, Johor
- `JHR02` - Johor Bahru, Kota Tinggi, Kulai, Mersing, Pontian, Seri Medan dan Timur
- `KUL01` - Kuala Lumpur, Putrajaya
- `SGR01` - Seluruh Negeri Selangor, Kuala Lumpur dan Putrajaya

For a complete list of zone codes, refer to the official JAKIM documentation.

## API Reference

### WaktuSolat.getWaktuSolatV2(String zoneCode)

Fetches prayer times for the specified zone code.

**Parameters:**

- `zoneCode`: JAKIM zone code (e.g., 'SGR01')

**Returns:**

- `Future<WaktuSolatV2>`: Prayer times data for the current month

**Throws:**

- `Exception`: If the API request fails or returns invalid data

## Error Handling

The package includes comprehensive error handling:

```dart
try {
  final waktuSolat = await WaktuSolat.getWaktuSolatV2('INVALID_CODE');
} catch (e) {
  if (e.toString().contains('Status code: 404')) {
    print('Invalid zone code provided');
  } else {
    print('Network or parsing error: $e');
  }
}
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- JAKIM
