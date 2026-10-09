import '../../core/bloc/list_bloc.dart';
import 'location.dart';
import 'locations_repository.dart';

class LocationsBloc extends ListBloc<Location> {
  LocationsBloc(this._repository);
  final LocationsRepository _repository;

  @override
  Future<List<Location>> fetch() => _repository.getAll();

  @override
  String nameOf(Location item) => item.name;
}
