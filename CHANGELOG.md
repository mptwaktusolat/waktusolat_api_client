## 2.0.0

**:boom: This version contains breaking changes.**

The `WaktuSolat` class has been refactored to no longer provide static methods for API calls. Use the `api` property to access the services instead:

- **The `WaktuSolat.getXxx(...)` static methods have been removed.** Call the service instead:

  ```dart
  // before
  final solat = await WaktuSolat.getWaktuSolatV2('SGR01');
  final zones = await WaktuSolat.getAllZones();

  // after
  final solat = await WaktuSolat.api.solatV2.getPrayerTimeByZone('SGR01');
  final zones = await WaktuSolat.api.zones.getAllZones();
  ```

  | Removed                                        | Replacement                                             |
  | ---------------------------------------------- | ------------------------------------------------------- |
  | `getWaktuSolatV2(zone, ...)`                   | `api.solatV2.getPrayerTimeByZone(zone, ...)`            |
  | `getWaktuSolatV2ByCoordinates(lat, long, ...)` | `api.solatV2.getPrayerTimeByGps(lat, long, ...)`        |
  | `getWaktuSolatV1(zone, ...)`                   | `api.solatV1.getMonthlyPrayerTime(zone, ...)`           |
  | `getWaktuSolatV1ByDay(zone, day, ...)`         | `api.solatV1.getDailyPrayerTime(zone, day, ...)`        |
  | `getAllZones()`                                | `api.zones.getAllZones()`                               |
  | `getZoneByState(state)`                        | `api.zones.getZonesByState(state)`                      |
  | `getZoneByCoordinates(lat, long)`              | `api.zones.getZonesByGps(lat, long)`                    |
  | `getChrono()`                                  | `api.chrono.getChrono()`                                |
  | `getJadualSolatDownloadUrl(zone, ...)`         | `api.jadualSolat.getJadualSolat(zone, ...)` — see below |

- **Failures throw `ChopperHttpException` instead of a generic `Exception`.** The whole response
  hangs off it, so the status code and error body are still reachable:

  ```dart
  // before
  } catch (e) { /* 'Failed to load prayer times. Status code: 404' */ }

  // after
  } on ChopperHttpException catch (e) { print(e.response.statusCode); }
  ```

- **`year` and `month` are no longer defaulted client-side.** Omitting them now sends no query
  parameters at all; the API already returns the current month in that case. Pass them explicitly
  if you need a specific month.

- **`getJadualSolatDownloadUrl` is now a real download.** Instead of building a URL string for you
  to fetch yourself, `api.jadualSolat.getJadualSolat(zone, {year, month})` performs the request and
  returns the PDF data:

  ```dart
  // before
  final url = WaktuSolat.getJadualSolatDownloadUrl('SGR01');

  // after
  final pdf = await WaktuSolat.api.jadualSolat.getJadualSolat('SGR01');
  await File('jadual_solat.pdf').writeAsBytes(pdf);
  ```

  If you only wanted the URL (eg: to hand to a browser or a download manager), build it from
  `WaktuSolatApi.defaultBaseUrl` yourself; the package no longer offers a helper for it.

### Other changes

- By default, every request includes the User-Agent `waktusolat.app api client library 2.0.0`.
  You can override it with `WaktuSolatApi.setUserAgent('my-app/1.0.0')`.

## 1.0.0

- Initial version.
