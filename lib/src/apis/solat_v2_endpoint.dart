import 'package:chopper/chopper.dart';
import 'package:waktusolat_api_client/src/models/mpt_waktu_solat_v2.dart';

part 'solat_v2_endpoint.chopper.g.dart';

@ChopperApi(baseUrl: '/v2/solat')
abstract class SolatV2Endpoint extends ChopperService {
  static SolatV2Endpoint create() => _$SolatV2Endpoint();

  @GET(path: '/{zone}')
  Future<Response<MPTWaktuSolatV2>> getPrayerTimeByZone(
    @Path() String zone, {
    @Query() int? year,
    @Query() int? month,
  });

  @GET(path: '/{lat}/{long}')
  Future<Response<MPTWaktuSolatV2>> getPrayerTimeByGps(
    @Path() double lat,
    @Path() double long, {
    @Query() int? year,
    @Query() int? month,
  });
}
