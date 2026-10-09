import '../../core/network/api_client.dart';
import 'episode.dart';

class EpisodesRepository {
  EpisodesRepository(this._api);
  final ApiClient _api;

  Future<List<Episode>> getAll() async =>
      (await _api.getAll('episode')).map(Episode.fromJson).toList();
}
