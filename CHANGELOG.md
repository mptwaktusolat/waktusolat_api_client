## 2.0.0

The `WaktuSolat` facade is gone. Its eight static methods each did nothing but call a Chopper
service and unwrap the response, so the services are now the API and `WaktuSolat` is only a holder
for a shared `WaktuSolatApi`.

### Breaking changes

- **The `WaktuSolat.getXxx(...)` static methods have been removed.** Call the service instead:

  ```dart
  // before
  final solat = await WaktuSolat.getWaktuSolatV2('SGR01');
  final zones = await WaktuSolat.getAllZones();

  // after
  final solat = await WaktuSolat.api.solatV2.getPrayerTimeByZone('SGR01');
  final zones = await WaktuSolat.api.zones.getAllZones();
  ```

  | Removed | Replacement |
  | --- | --- |
  | `getWaktuSolatV2(zone, ...)` | `api.solatV2.getPrayerTimeByZone(zone, ...)` |
  | `getWaktuSolatV2ByCoordinates(lat, long, ...)` | `api.solatV2.getPrayerTimeByGps(lat, long, ...)` |
  | `getWaktuSolatV1(zone, ...)` | `api.solatV1.getMonthlyPrayerTime(zone, ...)` |
  | `getWaktuSolatV1ByDay(zone, day, ...)` | `api.solatV1.getDailyPrayerTime(zone, day, ...)` |
  | `getAllZones()` | `api.zones.getAllZones()` |
  | `getZoneByState(state)` | `api.zones.getZonesByState(state)` |
  | `getZoneByCoordinates(lat, long)` | `api.zones.getZonesByGps(lat, long)` |
  | `getChrono()` | `api.chrono.getChrono()` |
  | `getJadualSolatDownloadUrl(zone, ...)` | `api.jadualSolat.getJadualSolat(zone, ...)` — see below |

- **Services return the decoded model, not `Response<T>`.** `getPrayerTimeByZone` now returns
  `Future<MPTWaktuSolatV2>` rather than `Future<Response<MPTWaktuSolatV2>>`, so `.body!` is no
  longer needed — or possible.

- **Failures throw `ChopperHttpException` instead of a generic `Exception`.** The whole response
  hangs off it, so the status code and error body are still reachable:

  ```dart
  // before
  } catch (e) { /* 'Failed to load prayer times. Status code: 404' */ }

  // after
  } on ChopperHttpException catch (e) { print(e.response.statusCode); }
  ```

- **`MptZone.fromList` has been removed.** The response converter already decodes JSON arrays into
  `List<MptZone>`, so the helper was dead weight. Use `MptZone.fromJson` if you are decoding a list
  by hand: `list.map((e) => MptZone.fromJson(e as Map<String, dynamic>)).toList()`.

- **`year` and `month` are no longer defaulted client-side.** Omitting them now sends no query
  parameters at all; the API already returns the current month in that case. Pass them explicitly
  if you need a specific month.

- **`getJadualSolatDownloadUrl` is now a real download.** Instead of building a URL string for you
  to fetch yourself, `api.jadualSolat.getJadualSolat(zone, {year, month})` performs the request and
  returns the PDF as `Uint8List`:

  ```dart
  // before — a URL, no request made
  final url = WaktuSolat.getJadualSolatDownloadUrl('SGR01');

  // after — the actual PDF bytes
  final pdf = await WaktuSolat.api.jadualSolat.getJadualSolat('SGR01');
  await File('jadual_solat.pdf').writeAsBytes(pdf);
  ```

  If you only wanted the URL — to hand to a browser or a download manager — build it from
  `WaktuSolatApi.defaultBaseUrl` yourself; the package no longer offers a helper for it.

### Other changes

- Added the `jadualSolat` service, the first endpoint in this package that returns a non-JSON body.
  It uses a per-method `@FactoryConverter` so the PDF bytes bypass the JSON converter entirely.
- Added `WaktuSolat.dispose()`, which disposes the shared instance and lets the next access to
  `WaktuSolat.api` build a fresh one.
- **Using this package no longer requires a dependency on `chopper`.** The two Chopper types you
  have to name — `ChopperHttpException` for error handling and `ChopperClient` for
  `WaktuSolatApi.withClient` — are re-exported from `package:waktusolat_api_client`. Everything else
  is reached through type inference.
- Added `WaktuSolatApi.errorConverter`, the converter that decodes a failed response's JSON body.
  Pass it alongside `WaktuSolatApi.converter` when building your own `ChopperClient`, instead of
  Chopper's `const JsonConverter()`.

## 1.0.0

- Initial version.
