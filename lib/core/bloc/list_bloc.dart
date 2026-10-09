import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ---- Events ----
sealed class ListEvent {}

class ListLoaded extends ListEvent {}

class ListSortToggled extends ListEvent {}

// ---- State ----
enum ListStatus { loading, success, failure }

class ListState<T> extends Equatable {
  const ListState({
    this.status = ListStatus.loading,
    this.items = const [],
    this.ascending = true,
    this.error,
  });

  final ListStatus status;
  final List<T> items;
  final bool ascending;
  final String? error;

  ListState<T> copyWith({
    ListStatus? status,
    List<T>? items,
    bool? ascending,
    String? error,
  }) =>
      ListState<T>(
        status: status ?? this.status,
        items: items ?? this.items,
        ascending: ascending ?? this.ascending,
        error: error,
      );

  @override
  List<Object?> get props => [status, items, ascending, error];
}

/// Базовая ViewModel списка: загрузка + сортировка по имени (А-Я / Я-А).
abstract class ListBloc<T> extends Bloc<ListEvent, ListState<T>> {
  ListBloc() : super(ListState<T>()) {
    on<ListLoaded>(_onLoaded);
    on<ListSortToggled>(_onSortToggled);
  }

  Future<List<T>> fetch();
  String nameOf(T item);

  List<T> _sorted(List<T> items, bool asc) {
    final list = [...items]..sort(
        (a, b) => nameOf(a).toLowerCase().compareTo(nameOf(b).toLowerCase()));
    return asc ? list : list.reversed.toList();
  }

  Future<void> _onLoaded(ListLoaded e, Emitter<ListState<T>> emit) async {
    emit(state.copyWith(status: ListStatus.loading));
    try {
      final items = await fetch();
      emit(state.copyWith(
        status: ListStatus.success,
        items: _sorted(items, state.ascending),
      ));
    } catch (err) {
      emit(state.copyWith(status: ListStatus.failure, error: err.toString()));
    }
  }

  void _onSortToggled(ListSortToggled e, Emitter<ListState<T>> emit) {
    final asc = !state.ascending;
    emit(state.copyWith(ascending: asc, items: _sorted(state.items, asc)));
  }
}
