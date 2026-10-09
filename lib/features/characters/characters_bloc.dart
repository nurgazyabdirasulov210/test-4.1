import '../../core/bloc/list_bloc.dart';
import 'character.dart';
import 'characters_repository.dart';

class CharactersBloc extends ListBloc<Character> {
  CharactersBloc(this._repository);
  final CharactersRepository _repository;

  @override
  Future<List<Character>> fetch() => _repository.getAll();

  @override
  String nameOf(Character item) => item.name;
}
