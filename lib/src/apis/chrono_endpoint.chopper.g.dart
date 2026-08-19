// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'chrono_endpoint.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$ChronoEndpoint extends ChronoEndpoint {
  _$ChronoEndpoint([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = ChronoEndpoint;

  @override
  Future<Response<Chrono>> getChrono() {
    final Uri $url = Uri.parse('/chrono');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<Chrono, Chrono>($request);
  }
}
