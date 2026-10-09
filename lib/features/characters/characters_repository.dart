import '../../core/network/api_client.dart';
import 'character.dart';

class CharactersRepository {
  CharactersRepository(this._api);
  final ApiClient _api;

  Future<List<Character>> getAll() async =>
      (await _api.getAll('character')).map(Character.fromJson).toList();
}
