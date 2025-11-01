import '../../../../core/database/database_helper.dart';
import '../models/movie_dto.dart';
import '../models/movies_response_dto.dart';

/// Local data source for movies using sqflite
class MoviesLocalDataSource {
  final DatabaseHelper _dbHelper;

  MoviesLocalDataSource(this._dbHelper);

  /// Cache movies response
  Future<void> cacheMovies(
    MoviesResponseDto response,
    int page,
    String category,
  ) async {
    final now = DateTime.now().millisecondsSinceEpoch;

    // Cache movies
    final movies = response.results.map((movie) {
      return {
        'id': movie.id,
        'title': movie.title,
        'overview': movie.overview,
        'poster_path': movie.posterPath,
        'backdrop_path': movie.backdropPath,
        'vote_average': movie.voteAverage,
        'vote_count': 0,
        'release_date': '',
        'genre_ids': movie.genreIds?.join(',') ?? '',
        'page': page,
        'category': category,
        'cached_at': now,
      };
    }).toList();

    await _dbHelper.insertMovies(movies);

    // Cache metadata
    await _dbHelper.insertMetadata({
      'category': category,
      'page': page,
      'total_pages': response.totalPages,
      'total_results': response.totalResults,
      'cached_at': now,
    });
  }

  /// Get cached movies for a specific page
  Future<MoviesResponseDto?> getCachedMovies(
    String category,
    int page,
  ) async {
    final movies = await _dbHelper.getMovies(category, page);
    final metadata = await _dbHelper.getMetadata(category, page);

    if (movies.isEmpty || metadata == null) return null;

    final movieDtos = movies.map((map) {
      return MovieDto(
        id: map['id'] as int,
        title: map['title'] as String?,
        overview: map['overview'] as String?,
        posterPath: map['poster_path'] as String?,
        backdropPath: map['backdrop_path'] as String?,
        voteAverage: map['vote_average'] as double?,
        genreIds: (map['genre_ids'] as String?)
                ?.split(',')
                .where((e) => e.isNotEmpty)
                .map((e) => int.tryParse(e) ?? 0)
                .toList() ??
            [],
      );
    }).toList();

    return MoviesResponseDto(
      page: metadata['page'] as int,
      results: movieDtos,
      totalPages: metadata['total_pages'] as int,
      totalResults: metadata['total_results'] as int,
    );
  }

  /// Clear old cache
  Future<void> clearOldCache() async {
    await _dbHelper.clearOldCache();
  }

  /// Clear all cache for category
  Future<void> clearCategory(String category) async {
    await _dbHelper.clearCategory(category);
  }
}
