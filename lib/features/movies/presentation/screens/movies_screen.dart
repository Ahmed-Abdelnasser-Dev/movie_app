import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../bloc/movies_cubit.dart';
import '../widgets/movies_body.dart';

/// Main screen for displaying the list of movies
class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MoviesCubit>()..fetchInitial(),
      child: Scaffold(
        appBar: AppBar(title: const Text('🎬 Movies')),
        body: const MoviesBody(),
      ),
    );
  }
}
