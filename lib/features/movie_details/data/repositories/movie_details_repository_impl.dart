import '../../../../core/network/api_result.dart';
import '../../../../core/network/connectivity_service.dart';
import '../../../../core/network/api_error_handler.dart';
import '../../domain/entities/movie_details.dart';
import '../../domain/entities/genre.dart';
import '../../domain/entities/cast_member.dart';
import '../../domain/repositories/movie_details_repository.dart';
import '../apis/movie_details_api_service.dart';
import '../sources/movie_details_local_data_source.dart';
import '../models/movie_details_dto.dart';
import '../models/credits_dto.dart';

class MovieDetailsRepositoryImpl implements MovieDetailsRepository {
  final MovieDetailsApiService _apiService;
  final MovieDetailsLocalDataSource _localDataSource;
  final ConnectivityService _connectivityService;

  MovieDetailsRepositoryImpl(
    this._apiService,
    this._localDataSource,
    this._connectivityService,
  );

  @override
  Future<ApiResult<MovieDetails>> getMovieDetails(int movieId) async {
    final isConnected = await _connectivityService.isConnected();

    if (isConnected) {
      try {
        // Fetch movie details and credits in parallel
        final results = await Future.wait([
          _apiService.getMovieDetails(movieId: movieId),
          _apiService.getMovieCredits(movieId: movieId),
        ]);

        final detailsDto = results[0] as MovieDetailsDto;
        final creditsDto = results[1] as CreditsDto;

        // Map to domain entity
        final movieDetails = _mapToEntity(detailsDto, creditsDto);

        // Cache the result
        await _localDataSource.cacheMovieDetails(detailsDto, creditsDto);

        return ApiResult.success(movieDetails);
      } catch (error) {
        // Try to get from cache on error
        final cachedData =
            await _localDataSource.getCachedMovieDetails(movieId);
        if (cachedData != null) {
          final (detailsDto, creditsDto) = cachedData;
          final movieDetails = _mapToEntity(detailsDto, creditsDto);
          return ApiResult.success(movieDetails);
        }
        return ApiResult.failure(ErrorHandler.handle(error));
      }
    } else {
      // Offline - try cache
      final cachedData = await _localDataSource.getCachedMovieDetails(movieId);
      if (cachedData != null) {
        final (detailsDto, creditsDto) = cachedData;
        final movieDetails = _mapToEntity(detailsDto, creditsDto);
        return ApiResult.success(movieDetails);
      }
      return ApiResult.failure(ErrorHandler.handle(
          Exception('No internet connection and no cached data')));
    }
  }

  MovieDetails _mapToEntity(MovieDetailsDto detailsDto, CreditsDto creditsDto) {
    return MovieDetails(
      id: detailsDto.id,
      title: detailsDto.title,
      overview: detailsDto.overview,
      posterPath: detailsDto.posterPath,
      backdropPath: detailsDto.backdropPath,
      voteAverage: detailsDto.voteAverage,
      voteCount: detailsDto.voteCount,
      genres:
          detailsDto.genres.map((g) => Genre(id: g.id, name: g.name)).toList(),
      runtime: detailsDto.runtime,
      releaseDate: detailsDto.releaseDate,
      status: detailsDto.status,
      budget: detailsDto.budget,
      revenue: detailsDto.revenue,
      tagline: detailsDto.tagline,
      cast: creditsDto.cast
          .take(10) // Limit to top 10 cast members
          .map((c) => CastMember(
                id: c.id,
                name: c.name,
                character: c.character,
                profilePath: c.profilePath,
              ))
          .toList(),
    );
  }
}
