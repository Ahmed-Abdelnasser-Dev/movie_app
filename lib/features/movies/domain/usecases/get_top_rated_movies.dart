import 'package:movie_app/core/network/api_result.dart';
import '../../data/models/movie_dto.dart';
import '../../data/models/movies_response_dto.dart';
import '../../data/repositories/movies_repository.dart';
import '../entities/movie.dart';
import '../entities/paged_movies.dart';

class GetTopRatedMovies {
  final MoviesRepository _repo;
  GetTopRatedMovies(this._repo);

  Future<ApiResult<PagedMovies>> call(int page) async {
    final result = await _repo.getTopRated(page: page);
    return result.when(
      success: (MoviesResponseDto dto) {
        final movies = dto.results
            .map((MovieDto m) => Movie(
                  id: m.id,
                  title: m.title ?? m.originalTitle ?? 'Untitled',
                  overview: m.overview,
                  posterPath: m.posterPath,
                  voteAverage: m.voteAverage,
                  genreIds: m.genreIds,
                ))
            .toList();
        return ApiResult.success(PagedMovies(
          page: dto.page,
          totalPages: dto.totalPages,
          totalResults: dto.totalResults,
          movies: movies,
        ));
      },
      failure: (error) => ApiResult.failure(error),
    );
  }
}
