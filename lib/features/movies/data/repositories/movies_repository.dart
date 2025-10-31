import 'package:movie_app/core/network/api_error_handler.dart';
import 'package:movie_app/core/network/api_result.dart';
import '../apis/movies_api_service.dart';
import '../models/movies_response_dto.dart';

class MoviesRepository {
  final MoviesApiService _api;
  MoviesRepository(this._api);

  Future<ApiResult<MoviesResponseDto>> getTopRated({int page = 1}) async {
    try {
      final res = await _api.getTopRatedMovies(page: page);
      return ApiResult.success(res);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
