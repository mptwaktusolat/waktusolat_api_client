/// A Dart client for the Waktu Solat API (https://api.waktusolat.app).
library;

export 'src/waktusolat_api.dart';

export 'package:chopper/chopper.dart' show ChopperHttpException;

// Endpoints
export 'src/apis/chrono_endpoint.dart';
export 'src/apis/jadual_solat_endpoint.dart';
export 'src/apis/solat_v1_endpoint.dart';
export 'src/apis/solat_v2_endpoint.dart';
export 'src/apis/zones_endpoint.dart';

// Converters
export 'src/converters/epoch_date_time_converter.dart';

// Models
export 'src/models/chrono.dart';
export 'src/models/hijri_date.dart';
export 'src/models/mpt_prayer_time.dart';
export 'src/models/mpt_prayer.dart';
export 'src/models/mpt_solat_v1_day.dart';
export 'src/models/mpt_solat_v1_month.dart';
export 'src/models/mpt_waktu_solat_v2.dart';
export 'src/models/mpt_zone_by_gps.dart';
export 'src/models/mpt_zone.dart';
