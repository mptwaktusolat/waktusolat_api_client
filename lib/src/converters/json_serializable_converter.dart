import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:waktusolat_api_client/src/models/chrono.dart';
import 'package:waktusolat_api_client/src/models/mpt_solat_v1_day.dart';
import 'package:waktusolat_api_client/src/models/mpt_solat_v1_month.dart';
import 'package:waktusolat_api_client/src/models/mpt_waktu_solat_v2.dart';
import 'package:waktusolat_api_client/src/models/mpt_zone.dart';
import 'package:waktusolat_api_client/src/models/mpt_zone_by_gps.dart';

/// Builds a model from its decoded JSON representation.
typedef JsonFactory<T> = T Function(Map<String, dynamic> json);

/// Maps every model type an endpoint can return to its `fromJson` factory.
///
/// Chopper only knows the [Type] it was asked to produce, so a new endpoint
/// returning a new model needs one extra line here.
final Map<Type, JsonFactory> waktuSolatJsonFactories = <Type, JsonFactory>{
  Chrono: Chrono.fromJson,
  MPTWaktuSolatV2: MPTWaktuSolatV2.fromJson,
  MptSolatV1Day: MptSolatV1Day.fromJson,
  MptSolatV1Month: MptSolatV1Month.fromJson,
  MptZone: MptZone.fromJson,
  MptZoneByGPS: MptZoneByGPS.fromJson,
};

/// A chopper [Converter] that turns decoded JSON into `json_serializable`
/// models using a [Type] to `fromJson` registry.
///
/// Chopper's own [JsonConverter] stops at `json.decode`, leaving the response
/// body as a raw `Map` or `List`. This subclass takes it the rest of the way,
/// handling both single objects (`send<Chrono, Chrono>`) and lists
/// (`send<List<MptZone>, MptZone>`).
class JsonSerializableConverter extends JsonConverter {
  const JsonSerializableConverter(this.factories);

  final Map<Type, JsonFactory> factories;

  @override
  FutureOr<Response<BodyType>> convertResponse<BodyType, InnerType>(
    Response response,
  ) async {
    // Decode with dynamic type arguments on purpose: the inherited
    // implementation ends in `as Response<BodyType>`, which would throw on the
    // raw Map/List we still have at this point.
    final Response jsonRes = await super.convertResponse<dynamic, dynamic>(
      response,
    );

    final body = jsonRes.body;
    if (body == null) return jsonRes.copyWith<BodyType>();

    return jsonRes.copyWith<BodyType>(body: _decode<InnerType>(body));
  }

  dynamic _decode<T>(Object entity) {
    if (entity is Iterable) return _decodeList<T>(entity);
    if (entity is Map<String, dynamic>) return _decodeMap<T>(entity);

    return entity;
  }

  List<T> _decodeList<T>(Iterable values) => values
      .whereType<Object>()
      .map<T>((value) => _decode<T>(value) as T)
      .toList();

  T? _decodeMap<T>(Map<String, dynamic> values) {
    final factory = factories[T];
    if (factory == null) return null;

    return factory(values) as T;
  }
}
