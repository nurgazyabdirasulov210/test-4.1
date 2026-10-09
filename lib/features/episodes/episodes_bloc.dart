import '../../core/bloc/list_bloc.dart';
import 'episode.dart';
import 'episodes_repository.dart';

class EpisodesBloc extends ListBloc<Episode> {
  EpisodesBloc(this._repository);
  final EpisodesRepository _repository;

  @override
  Future<List<Episode>> fetch() => _repository.getAll();

  @override
  String nameOf(Episode item) => item.name;
}
