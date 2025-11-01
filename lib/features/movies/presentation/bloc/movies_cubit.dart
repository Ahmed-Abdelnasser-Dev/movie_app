import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/network/api_result.dart';
import '../../data/repositories/movies_repository.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/paged_movies.dart';
import '../../domain/usecases/get_top_rated_movies.dart';

part 'movies_state.dart';
part 'movies_cubit.freezed.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final GetTopRatedMovies _getTopRatedMovies;
  final MoviesRepository _repository;

  MoviesCubit(this._getTopRatedMovies, this._repository)
      : super(const MoviesState.initial());

  int _currentPage = 0;
  bool _isLoadingMore = false;
  bool _isOffline = false;

  bool get isOffline => _isOffline;

  Future<void> fetchInitial() async {
    emit(const MoviesState.loading());
    _currentPage = 1;

    // Check connectivity
    _isOffline = !(await _repository.isConnected());

    final result = await _getTopRatedMovies(_currentPage);
    result.when(
      success: (PagedMovies data) {
        emit(MoviesState.success(
          movies: data.movies,
          page: data.page,
          hasMore: data.hasMore,
          isOffline: _isOffline,
        ));
      },
      failure: (err) => emit(MoviesState.error(
          err.apiErrorModel.message ?? 'Something went wrong')),
    );
  }

  Future<void> loadMore() async {
    final current = state;
    if (current is _Success && !_isLoadingMore && current.hasMore) {
      _isLoadingMore = true;
      emit(current.copyWith(isLoadingMore: true));
      _currentPage += 1;

      // Check connectivity again
      _isOffline = !(await _repository.isConnected());

      final result = await _getTopRatedMovies(_currentPage);
      result.when(
        success: (data) {
          final updated = List<Movie>.from(current.movies)..addAll(data.movies);
          emit(current.copyWith(
            movies: updated,
            page: data.page,
            hasMore: data.hasMore,
            isLoadingMore: false,
            isOffline: _isOffline,
          ));
        },
        failure: (err) {
          emit(current.copyWith(isLoadingMore: false));
        },
      );
      _isLoadingMore = false;
    }
  }
}
