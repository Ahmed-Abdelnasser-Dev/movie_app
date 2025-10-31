import 'movie.dart';

class PagedMovies {
  final int page;
  final int totalPages;
  final int totalResults;
  final List<Movie> movies;

  const PagedMovies({
    required this.page,
    required this.totalPages,
    required this.totalResults,
    required this.movies,
  });

  bool get hasMore => page < totalPages;
}
