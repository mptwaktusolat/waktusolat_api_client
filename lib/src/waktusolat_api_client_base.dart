import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:waktusolat_api_client/src/models/mpt_solat_v1_day.dart';
import 'package:waktusolat_api_client/src/models/mpt_zone.dart';
import 'package:waktusolat_api_client/src/models/mpt_zone_by_gps.dart';
import 'models/mpt_waktu_solat_v2.dart';

/// Main API client for Waktu Solat API
class WaktuSolat {
  static const String _baseUrl = 'https://api.waktusolat.app';

  /// Get prayer times for a specific zone (Version 2)
  ///
  /// [zoneCode] - The JAKIM zone code (e.g., 'SGR01')
  ///
  /// Returns [MPTWaktuSolatV2] object containing prayer times data
  static Future<MPTWaktuSolatV2> getWaktuSolatV2(
    String zoneCode, {
    int? year,
    int? month,
  }) async {
    var date = DateTime(
      year ?? DateTime.now().year,
      month ?? DateTime.now().month,
    );

    final queryParams = {
      'year': date.year.toString(),
      'month': date.month.toString(),
    };

    final url = Uri.parse(
      '$_baseUrl/v2/solat/$zoneCode',
    ).replace(queryParameters: queryParams);

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        return MPTWaktuSolatV2.fromJson(jsonData);
      } else {
        throw Exception(
          'Failed to load prayer times. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching prayer times: $e');
    }
  }

  /// Get prayer times for a given coordinates (Version 2)
  ///
  /// [zoneCode] - The JAKIM zone code (e.g., 'SGR01')
  ///
  /// Returns [MPTWaktuSolatV2] object containing prayer times data
  static Future<MPTWaktuSolatV2> getWaktuSolatV2ByCoordinates(
    double latitude,
    double longitude, {
    int? year,
    int? month,
  }) async {
    var date = DateTime(
      year ?? DateTime.now().year,
      month ?? DateTime.now().month,
    );

    final queryParams = {
      'year': date.year.toString(),
      'month': date.month.toString(),
    };

    final url = Uri.parse(
      '$_baseUrl/v2/solat/$latitude/$longitude',
    ).replace(queryParameters: queryParams);

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        return MPTWaktuSolatV2.fromJson(jsonData);
      } else {
        throw Exception(
          'Failed to load prayer times. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching prayer times: $e');
    }
  }

  /// Get prayer times for a specific zone (Version 1)
  ///
  /// [zoneCode] - The JAKIM zone code (e.g., 'SGR01')
  ///
  /// Returns [MPTWaktuSolatV2] object containing prayer times data
  static Future<MPTWaktuSolatV2> getWaktuSolatV1(
    String zoneCode, {
    int? year,
    int? month,
  }) async {
    var date = DateTime(
      year ?? DateTime.now().year,
      month ?? DateTime.now().month,
    );

    final queryParams = {'year': date.year, 'month': date.month};

    final url = Uri.parse(
      '$_baseUrl/solat/$zoneCode',
    ).replace(queryParameters: queryParams);

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        return MPTWaktuSolatV2.fromJson(jsonData);
      } else {
        throw Exception(
          'Failed to load prayer times. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching prayer times: $e');
    }
  }

  /// Get prayer times for a specific zone (Version 1)
  ///
  /// [zoneCode] - The JAKIM zone code (e.g., 'SGR01')
  ///
  /// Returns [MptSolatV1Day] object containing prayer times data
  static Future<MptSolatV1Day> getWaktuSolatV1ByDay(
    String zoneCode,
    int dayOfMonth, {
    int? year,
    int? month,
  }) async {
    var date = DateTime(
      year ?? DateTime.now().year,
      month ?? DateTime.now().month,
    );

    final queryParams = {'year': date.year, 'month': date.month};

    final url = Uri.parse(
      '$_baseUrl/solat/$zoneCode/$dayOfMonth',
    ).replace(queryParameters: queryParams);

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        return MptSolatV1Day.fromJson(jsonData);
      } else {
        throw Exception(
          'Failed to load prayer times. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching prayer times: $e');
    }
  }

  /// Get all available prayer time zones from the server
  ///
  /// Returns a [MptZone] object containing zone data
  static Future<List<MptZone>> getAllZones() async {
    final url = Uri.parse('$_baseUrl/zones');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return MptZone.fromList(jsonData);
      } else {
        throw Exception(
          'Failed to load zones data. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching zones data: $e');
    }
  }

  /// Get all zones for the current state
  ///
  /// [state] - The JAKIM zone code for the state (e.g., 'PRK'). Only the name, can omit the number.
  ///
  /// Returns a list of [MptZone] objects containing zone data
  static Future<List<MptZone>> getZoneByState(String state) async {
    final url = Uri.parse('$_baseUrl/zones/$state');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return MptZone.fromList(jsonData);
      } else {
        throw Exception(
          'Failed to load zones data. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching zones data: $e');
    }
  }

  /// Get all zones for the current state
  ///
  /// Returns a list of [MptZone] objects containing zone data
  static Future<MptZoneByGPS> getZoneByCoordinates(
    double latitude,
    double longitude,
  ) async {
    final url = Uri.parse('$_baseUrl/zones/$latitude/$longitude');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return MptZoneByGPS.fromJson(jsonData);
      } else {
        throw Exception(
          'Failed to load zones data. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching zones data: $e');
    }
  }

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
    var date = DateTime(
      year ?? DateTime.now().year,
      month ?? DateTime.now().month,
    );

    final queryParams = {
      'year': date.year.toString(),
      'month': date.month.toString(),
    };

    final url = Uri.parse(
      '$_baseUrl/jadual_solat/$zoneCode',
    ).replace(queryParameters: queryParams);

    return url.toString();
  }
}
