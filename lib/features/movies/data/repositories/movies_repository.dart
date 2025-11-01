import 'package:movie_app/core/network/api_error_handler.dart';
import 'package:movie_app/core/network/api_result.dart';
import 'package:movie_app/core/network/connectivity_service.dart';
import '../apis/movies_api_service.dart';
import '../models/movies_response_dto.dart';
import '../sources/movies_local_data_source.dart';

class MoviesRepository {
  final MoviesApiService _api;
  final MoviesLocalDataSource _localDataSource;
  final ConnectivityService _connectivityService;

  MoviesRepository(
    this._api,
    this._localDataSource,
    this._connectivityService,
  );

  Future<ApiResult<MoviesResponseDto>> getTopRated({int page = 1}) async {
    const category = 'top_rated';

    // Check connectivity
    final isConnected = await _connectivityService.isConnected();

    if (isConnected) {
      // Try to fetch from API
      try {
        final res = await _api.getTopRatedMovies(page: page);
        // Cache the response
        await _localDataSource.cacheMovies(res, page, category);
        return ApiResult.success(res);
      } catch (error) {
        // If API fails, try to get from cache
        final cachedData =
            await _localDataSource.getCachedMovies(category, page);
        if (cachedData != null) {
          return ApiResult.success(cachedData);
        }
        return ApiResult.failure(ErrorHandler.handle(error));
      }
    } else {
      // Offline: get from cache
      final cachedData = await _localDataSource.getCachedMovies(category, page);
      if (cachedData != null) {
        return ApiResult.success(cachedData);
      }
      return ApiResult.failure(
        ErrorHandler.handle(
            Exception('No internet connection and no cached data')),
      );
    }
  }

  /// Check if device is connected to internet
  Future<bool> isConnected() async {
    return await _connectivityService.isConnected();
  }
}
