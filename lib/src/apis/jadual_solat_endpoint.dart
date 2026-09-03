import 'dart:typed_data';

import 'package:chopper/chopper.dart';

part 'jadual_solat_endpoint.chopper.g.dart';

/// Downloads the JAKIM prayer timetable as a PDF.
@ChopperApi(baseUrl: '/jadual_solat')
abstract class JadualSolatEndpoint extends ChopperService {
  static JadualSolatEndpoint create([ChopperClient? client]) =>
      _$JadualSolatEndpoint(client);

  static Response<Uint8List> pdfConverter(Response response) =>
      response.copyWith<Uint8List>(body: response.bodyBytes);

  /// Fetches the timetable PDF for [zone] as bytes.
  ///
  /// [year] and [month] default to the current month server-side when omitted.
  @GET(path: '/{zone}', headers: {'Accept': 'application/pdf'})
  @FactoryConverter(response: pdfConverter)
  Future<Uint8List> getJadualSolat(
    @Path() String zone, {
    @Query() int? year,
    @Query() int? month,
  });
}
