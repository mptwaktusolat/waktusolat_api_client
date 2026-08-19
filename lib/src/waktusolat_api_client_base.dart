import 'package:chopper/chopper.dart';
import 'package:waktusolat_api_client/src/models/chrono.dart';
import 'package:waktusolat_api_client/src/models/mpt_solat_v1_day.dart';
import 'package:waktusolat_api_client/src/models/mpt_solat_v1_month.dart';
import 'package:waktusolat_api_client/src/models/mpt_zone.dart';
import 'package:waktusolat_api_client/src/models/mpt_zone_by_gps.dart';
import 'package:waktusolat_api_client/src/waktusolat_api.dart';
import 'models/mpt_waktu_solat_v2.dart';

/// Main API client for Waktu Solat API.
class WaktuSolat {
  WaktuSolat._();

  static WaktuSolatApi? _api;

  static WaktuSolatApi get api => _api ??= WaktuSolatApi();

  static set api(WaktuSolatApi value) => _api = value;

  /// Get prayer times for a specific zone (Version 2)
  ///
  /// [zoneCode] The JAKIM zone code (e.g., 'SGR01')
  ///
  /// Returns [MPTWaktuSolatV2] object containing prayer times data
  static Future<MPTWaktuSolatV2> getWaktuSolatV2(
    String zoneCode, {
    int? year,
    int? month,
  }) {
    final date = _monthOf(year, month);

    return _call(
      () => api.solatV2.getPrayerTimeByZone(
        zoneCode,
        year: date.year,
        month: date.month,
      ),
      'prayer times',
    );
  }

  /// Get prayer times for a given coordinates (Version 2)
  ///
  /// [latitude], [longitude] - The coordinates to look up
  ///
  /// Returns [MPTWaktuSolatV2] object containing prayer times data
  static Future<MPTWaktuSolatV2> getWaktuSolatV2ByCoordinates(
    double latitude,
    double longitude, {
    int? year,
    int? month,
  }) {
    final date = _monthOf(year, month);

    return _call(
      () => api.solatV2.getPrayerTimeByGps(
        latitude,
        longitude,
        year: date.year,
        month: date.month,
      ),
      'prayer times',
    );
  }

  /// Get prayer times for a specific zone (Version 1)
  ///
  /// [zoneCode] - The JAKIM zone code (e.g., 'SGR01')
  ///
  /// Returns [MptSolatV1Month] object containing prayer times data
  static Future<MptSolatV1Month> getWaktuSolatV1(
    String zoneCode, {
    int? year,
    int? month,
  }) {
    final date = _monthOf(year, month);

    return _call(
      () => api.solatV1.getMonthlyPrayerTime(
        zoneCode,
        year: date.year,
        month: date.month,
      ),
      'prayer times',
    );
  }

  /// Get prayer times for a single day of a specific zone (Version 1)
  ///
  /// [zoneCode] - The JAKIM zone code (e.g., 'SGR01')
  /// [dayOfMonth] - The day of the month to look up
  ///
  /// Returns [MptSolatV1Day] object containing prayer times data
  static Future<MptSolatV1Day> getWaktuSolatV1ByDay(
    String zoneCode,
    int dayOfMonth, {
    int? year,
    int? month,
  }) {
    final date = _monthOf(year, month);

    return _call(
      () => api.solatV1.getDailyPrayerTime(
        zoneCode,
        dayOfMonth,
        year: date.year,
        month: date.month,
      ),
      'prayer times',
    );
  }

  /// Get all available prayer time zones from the server
  ///
  /// Returns a list of [MptZone] objects containing zone data
  static Future<List<MptZone>> getAllZones() =>
      _call(() => api.zones.getAllZones(), 'zones data');

  /// Get all zones for the current state
  ///
  /// [state] - The JAKIM zone code for the state (e.g., 'PRK'). Only the name, can omit the number.
  ///
  /// Returns a list of [MptZone] objects containing zone data
  static Future<List<MptZone>> getZoneByState(String state) =>
      _call(() => api.zones.getZonesByState(state), 'zones data');

  /// Get the zone covering a given coordinates
  ///
  /// Returns a [MptZoneByGPS] object containing zone data
  static Future<MptZoneByGPS> getZoneByCoordinates(
    double latitude,
    double longitude,
  ) => _call(
    () => api.zones.getZonesByGps(latitude, longitude),
    'zones data',
  );

  /// Get the current date and time as reported by the server
  ///
  /// Returns a [Chrono] object containing the server's date and time
  static Future<Chrono> getChrono() =>
      _call(() => api.chrono.getChrono(), 'server time');

  /// Generates the download URL for the Jadual Solat (prayer timetable) PDF for a specific [zoneCode].
  ///
  /// Returns the URL as a [String] that can be used to download the Jadual Solat PDF.
  ///
  /// **Note:** This function only generates the download URL. The actual PDF download and handling
  /// should be implemented by the application.
  static String getJadualSolatDownloadUrl(
    String zoneCode, {
    int? year,
    int? month,
  }) {
    final date = _monthOf(year, month);

    return WaktuSolatApi.defaultBaseUrl
        .replace(
          path: '/jadual_solat/$zoneCode',
          queryParameters: {
            'year': date.year.toString(),
            'month': date.month.toString(),
          },
        )
        .toString();
  }

  /// The [year]/[month] pair to query, falling back to the current month.
  static DateTime _monthOf(int? year, int? month) => DateTime(
    year ?? DateTime.now().year,
    month ?? DateTime.now().month,
  );

  /// Runs [request] and returns its body, translating both HTTP failures and
  /// transport errors into an [Exception] describing [what] failed.
  static Future<T> _call<T>(
    Future<Response<T>> Function() request,
    String what,
  ) async {
    final Response<T> response;
    try {
      response = await request();
    } catch (e) {
      throw Exception('Error fetching $what: $e');
    }

    final body = response.body;
    if (!response.isSuccessful || body == null) {
      throw Exception(
        'Failed to load $what. Status code: ${response.statusCode}',
      );
    }

    return body;
  }
}
