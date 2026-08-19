import 'package:chopper/chopper.dart';
import 'package:waktusolat_api_client/src/models/mpt_zone_by_gps.dart';
import 'package:waktusolat_api_client/src/models/mpt_zones.dart';

part 'zones_endpoint.chopper.g.dart';

@ChopperApi(baseUrl: '/zones')
abstract class ZonesEndpoint extends ChopperService {
  static ZonesEndpoint create() => _$ZonesEndpoint();

  @GET()
  Future<Response<MptZones>> getAllZones();

  @GET(path: '/{state}')
  Future<Response<MptZones>> getZonesByState(
    @Path() String state,
  );

  @GET(path: '/{lat}/{long}')
  Future<Response<MptZoneByGPS>> getZonesByGps(
    @Path() double lat,
    @Path() double long,
  );
}
