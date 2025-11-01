import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/network/connectivity_service.dart';
import '../../domain/usecases/get_movie_details.dart';
import 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final GetMovieDetailsUseCase _getMovieDetailsUseCase;
  final ConnectivityService _connectivityService;

  MovieDetailsCubit(
    this._getMovieDetailsUseCase,
    this._connectivityService,
  ) : super(const MovieDetailsState.initial());

  Future<void> fetchMovieDetails(int movieId) async {
    emit(const MovieDetailsState.loading());

    final isOffline = !await _connectivityService.isConnected();

    final result = await _getMovieDetailsUseCase(movieId);

    result.when(
      success: (movieDetails) {
        emit(MovieDetailsState.success(
          movieDetails: movieDetails,
          isOffline: isOffline,
        ));
      },
      failure: (errorHandler) {
        emit(MovieDetailsState.error(
            errorHandler.apiErrorModel.message ?? 'Unknown error'));
      },
    );
  }
}
