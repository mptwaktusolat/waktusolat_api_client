import 'package:chopper/chopper.dart';
import 'package:waktusolat_api_client/src/models/mpt_solat_v1_day.dart';
import 'package:waktusolat_api_client/src/models/mpt_solat_v1_month.dart';

part 'solat_v1_endpoint.chopper.g.dart';

@ChopperApi(baseUrl: '/solat')
abstract class SolatV1Endpoint extends ChopperService {
  static SolatV1Endpoint create([ChopperClient? client]) =>
      _$SolatV1Endpoint(client);

  @GET(path: '/{zone}')
  Future<MptSolatV1Month> getMonthlyPrayerTime(
    @Path() String zone, {
    @Query() int? year,
    @Query() int? month,
  });

  @GET(path: '/{zone}/{day}')
  Future<MptSolatV1Day> getDailyPrayerTime(
    @Path() String zone,
    @Path() int day, {
    @Query() int? year,
    @Query() int? month,
  });
}
