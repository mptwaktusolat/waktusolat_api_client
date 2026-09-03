import 'package:chopper/chopper.dart';
import 'package:waktusolat_api_client/src/models/mpt_waktu_solat_v2.dart';

part 'solat_v2_endpoint.chopper.g.dart';

@ChopperApi(baseUrl: '/v2/solat')
abstract class SolatV2Endpoint extends ChopperService {
  static SolatV2Endpoint create([ChopperClient? client]) =>
      _$SolatV2Endpoint(client);

  @GET(path: '/{zone}')
  Future<MPTWaktuSolatV2> getPrayerTimeByZone(
    @Path() String zone, {
    @Query() int? year,
    @Query() int? month,
  });

  @GET(path: '/gps/{lat}/{long}')
  Future<MPTWaktuSolatV2> getPrayerTimeByGps(
    @Path() double lat,
    @Path() double long, {
    @Query() int? year,
    @Query() int? month,
  });
}
