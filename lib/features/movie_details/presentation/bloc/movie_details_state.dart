import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/movie_details.dart';

part 'movie_details_state.freezed.dart';

@freezed
class MovieDetailsState with _$MovieDetailsState {
  const factory MovieDetailsState.initial() = _Initial;
  const factory MovieDetailsState.loading() = _Loading;
  const factory MovieDetailsState.success({
    required MovieDetails movieDetails,
    required bool isOffline,
  }) = _Success;
  const factory MovieDetailsState.error(String message) = _Error;
}
