import 'package:waktusolat_api_client/waktusolat_api_client.dart';

void main() async {
  // Example 1: Fetch prayer times for current month
  await fetchPrayerTimesForZone('SGR01');

  // Example 2: List all available zones
  await fetchAllZones();

  // Example 3: List all available zones for a specific state
  await fetchZonesForSelectedState('prk');

  // Example 4: Handle a failed request
  await fetchInvalidZone();

  WaktuSolat.dispose();
}

/// Example 1: Fetching prayer time for current month
Future<void> fetchPrayerTimesForZone(String zoneCode) async {
  print('Fetching prayer times for $zoneCode...');
  final waktuSolat = await WaktuSolat.api.solatV2.getPrayerTimeByZone(zoneCode);

  print('Zone: ${waktuSolat.zone}');
  print(
    'Month: ${waktuSolat.month} (${waktuSolat.monthNumber}) ${waktuSolat.year}',
  );

  final today = DateTime.now().day;

  final todayPrayer = waktuSolat.prayers[today - 1];
  print('Today\'s prayers:');
  print('Imsak: ${todayPrayer.imsak}');
  print('Fajr: ${todayPrayer.fajr}');
  print('Dhuha: ${todayPrayer.dhuha}');
  print('Dhuhr: ${todayPrayer.dhuhr}');
  print('Asr: ${todayPrayer.asr}');
  print('Maghrib: ${todayPrayer.maghrib}');
  print('Isha: ${todayPrayer.isha}');
}

/// Example 2: List all available zones
Future<void> fetchAllZones() async {
  print('\nFetching all available zones...');
  final mptZones = await WaktuSolat.api.zones.getAllZones();

  print(
    'All zones retrieved: ${mptZones.map((zone) => zone.jakimCode).join(', ')}',
  );
}

/// Example 3: List all available zones for a state
Future<void> fetchZonesForSelectedState(String state) async {
  print('\nFetching all available zones...');
  final mptZones = await WaktuSolat.api.zones.getZonesByState(state);

  print(
    'Zones under $state retrieved: ${mptZones.map((zone) => zone.jakimCode).join(', ')}',
  );
}

/// Example 4: A failed request throws [ChopperHttpException]
Future<void> fetchInvalidZone() async {
  print('\nFetching an invalid zone...');
  try {
    await WaktuSolat.api.solatV2.getPrayerTimeByZone('INVALID');
  } on ChopperHttpException catch (e) {
    print('Request failed with ${e.response.statusCode}: ${e.response.error}');
  }
}
