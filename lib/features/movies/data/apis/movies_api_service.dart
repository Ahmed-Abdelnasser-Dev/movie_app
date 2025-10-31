import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/network/api_constants.dart';
import '../models/movies_response_dto.dart';

part 'movies_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class MoviesApiService {
  factory MoviesApiService(Dio dio) = _MoviesApiService;

  @GET(ApiConstants.topRatedMovies)
  Future<MoviesResponseDto> getTopRatedMovies({
    @Query('page') int page = 1,
    @Query('language') String language = 'en-US',
  });
}
