import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/network/api_constants.dart';
import '../models/movie_details_dto.dart';
import '../models/credits_dto.dart';

part 'movie_details_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class MovieDetailsApiService {
  factory MovieDetailsApiService(Dio dio) = _MovieDetailsApiService;

  @GET('${ApiConstants.movieDetails}{movieId}')
  Future<MovieDetailsDto> getMovieDetails({
    @Path('movieId') required int movieId,
    @Query('language') String language = 'en-US',
  });

  @GET('${ApiConstants.movieDetails}{movieId}/credits')
  Future<CreditsDto> getMovieCredits({
    @Path('movieId') required int movieId,
  });
}
