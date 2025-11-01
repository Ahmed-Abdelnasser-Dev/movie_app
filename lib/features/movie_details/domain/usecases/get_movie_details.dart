import '../../../../core/network/api_result.dart';
import '../entities/movie_details.dart';
import '../repositories/movie_details_repository.dart';

/// Use case to fetch detailed information about a specific movie.
class GetMovieDetailsUseCase {
  final MovieDetailsRepository _repository;

  GetMovieDetailsUseCase(this._repository);

  Future<ApiResult<MovieDetails>> call(int movieId) {
    return _repository.getMovieDetails(movieId);
  }
}
