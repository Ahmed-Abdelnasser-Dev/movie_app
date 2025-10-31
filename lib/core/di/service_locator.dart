import 'package:get_it/get_it.dart';
import '../network/dio_factory.dart';

import '../../features/movies/data/apis/movies_api_service.dart';
import '../../features/movies/data/repositories/movies_repository.dart';
import '../../features/movies/domain/usecases/get_top_rated_movies.dart';
import '../../features/movies/presentation/bloc/movies_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Dio
  final dio = DioFactory.getDio();

  // Services
  getIt.registerLazySingleton<MoviesApiService>(() => MoviesApiService(dio));

  // Repos
  getIt
      .registerLazySingleton<MoviesRepository>(() => MoviesRepository(getIt()));

  // Use cases
  getIt.registerLazySingleton<GetTopRatedMovies>(
      () => GetTopRatedMovies(getIt()));

  // Cubits
  getIt.registerFactory<MoviesCubit>(() => MoviesCubit(getIt()));
}
