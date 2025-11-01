import '../../../../core/network/api_result.dart';
import '../entities/movie_details.dart';

abstract class MovieDetailsRepository {
  Future<ApiResult<MovieDetails>> getMovieDetails(int movieId);
}
