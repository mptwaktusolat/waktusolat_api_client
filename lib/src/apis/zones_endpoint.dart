import 'package:chopper/chopper.dart';
import 'package:waktusolat_api_client/src/models/mpt_zone.dart';
import 'package:waktusolat_api_client/src/models/mpt_zone_by_gps.dart';

part 'zones_endpoint.chopper.g.dart';

@ChopperApi(baseUrl: '/zones')
abstract class ZonesEndpoint extends ChopperService {
  static ZonesEndpoint create([ChopperClient? client]) =>
      _$ZonesEndpoint(client);

  @GET()
  Future<List<MptZone>> getAllZones();

  @GET(path: '/{state}')
  Future<List<MptZone>> getZonesByState(@Path() String state);

  @GET(path: '/{lat}/{long}')
  Future<MptZoneByGPS> getZonesByGps(
    @Path() double lat,
    @Path() double long,
  );
}
