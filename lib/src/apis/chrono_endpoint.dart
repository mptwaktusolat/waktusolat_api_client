import 'package:chopper/chopper.dart';
import 'package:waktusolat_api_client/src/models/chrono.dart';

part 'chrono_endpoint.chopper.g.dart';

@ChopperApi(baseUrl: '/chrono')
abstract class ChronoEndpoint extends ChopperService {
  static ChronoEndpoint create() => _$ChronoEndpoint();

  @GET()
  Future<Response<Chrono>> getChrono();
}
