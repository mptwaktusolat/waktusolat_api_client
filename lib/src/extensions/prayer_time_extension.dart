import 'package:waktusolat_api_client/src/models/mpt_prayer.dart';

// TODO: Add documentation where i get the numbers

extension PrayerTimeExtension on MptPrayer {
  DateTime get imsak {
    return fajr.subtract(const Duration(minutes: 10));
  }

  DateTime get dhuha {
    return syuruk.add(const Duration(minutes: 28));
  }
}
