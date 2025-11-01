import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/widgets/app_toast.dart';
import '../bloc/movie_details_cubit.dart';
import '../bloc/movie_details_state.dart';
import '../widgets/movie_details_body.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;

  const MovieDetailsScreen({
    super.key,
    required this.movieId,
  });

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetIt.I<MovieDetailsCubit>()..fetchMovieDetails(widget.movieId),
      child: Scaffold(
        body: BlocConsumer<MovieDetailsCubit, MovieDetailsState>(
          listener: (context, state) {
            state.maybeWhen(
              error: (message) {
                AppToast.showError(context, message);
              },
              orElse: () {},
            );
          },
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const MovieDetailsBody.loading(),
              success: (movieDetails, isOffline) => MovieDetailsBody(
                movieDetails: movieDetails,
                isOffline: isOffline,
              ),
              error: (message) => MovieDetailsBody.error(message: message),
            );
          },
        ),
      ),
    );
  }
}
