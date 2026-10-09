import '../../core/network/api_client.dart';
import 'location.dart';

class LocationsRepository {
  LocationsRepository(this._api);
  final ApiClient _api;

  Future<List<Location>> getAll() async =>
      (await _api.getAll('location')).map(Location.fromJson).toList();
}
