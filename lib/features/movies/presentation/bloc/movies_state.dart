part of 'movies_cubit.dart';

@freezed
class MoviesState with _$MoviesState {
  const factory MoviesState.initial() = _Initial;
  const factory MoviesState.loading() = _Loading;
  const factory MoviesState.success({
    required List<Movie> movies,
    required int page,
    required bool hasMore,
    @Default(false) bool isLoadingMore,
  }) = _Success;
  const factory MoviesState.error(String message) = _Error;
}
