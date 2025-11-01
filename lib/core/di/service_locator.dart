import 'package:get_it/get_it.dart';
import '../database/database_helper.dart';
import '../network/connectivity_service.dart';
import '../network/dio_factory.dart';

import '../../features/movies/data/apis/movies_api_service.dart';
import '../../features/movies/data/repositories/movies_repository.dart';
import '../../features/movies/data/sources/movies_local_data_source.dart';
import '../../features/movies/domain/usecases/get_top_rated_movies.dart';
import '../../features/movies/presentation/bloc/movies_cubit.dart';

import '../../features/movie_details/data/apis/movie_details_api_service.dart';
import '../../features/movie_details/data/repositories/movie_details_repository_impl.dart';
import '../../features/movie_details/data/sources/movie_details_local_data_source.dart';
import '../../features/movie_details/domain/repositories/movie_details_repository.dart';
import '../../features/movie_details/domain/usecases/get_movie_details.dart';
import '../../features/movie_details/presentation/bloc/movie_details_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Core
  getIt.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  getIt.registerLazySingleton<ConnectivityService>(() => ConnectivityService());

  // Dio
  final dio = DioFactory.getDio();

  // Services
  getIt.registerLazySingleton<MoviesApiService>(() => MoviesApiService(dio));
  getIt.registerLazySingleton<MovieDetailsApiService>(
      () => MovieDetailsApiService(dio));

  // Data Sources
  getIt.registerLazySingleton<MoviesLocalDataSource>(
      () => MoviesLocalDataSource(getIt()));
  getIt.registerLazySingleton<MovieDetailsLocalDataSource>(
      () => MovieDetailsLocalDataSource(getIt()));

  // Repos
  getIt.registerLazySingleton<MoviesRepository>(
      () => MoviesRepository(getIt(), getIt(), getIt()));
  getIt.registerLazySingleton<MovieDetailsRepository>(
      () => MovieDetailsRepositoryImpl(getIt(), getIt(), getIt()));

  // Use cases
  getIt.registerLazySingleton<GetTopRatedMovies>(
      () => GetTopRatedMovies(getIt()));
  getIt.registerLazySingleton<GetMovieDetailsUseCase>(
      () => GetMovieDetailsUseCase(getIt()));

  // Cubits
  getIt.registerFactory<MoviesCubit>(() => MoviesCubit(getIt(), getIt()));
  getIt.registerFactory<MovieDetailsCubit>(
      () => MovieDetailsCubit(getIt(), getIt()));
}
