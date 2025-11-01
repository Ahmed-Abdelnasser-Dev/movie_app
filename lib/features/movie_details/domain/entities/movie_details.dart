import 'cast_member.dart';
import 'genre.dart';

/// Represents detailed information about a movie.
class MovieDetails {
  final int id;
  final String title;
  final String? overview;
  final String? posterPath;
  final String? backdropPath;
  final double? voteAverage;
  final int? voteCount;
  final List<Genre> genres;
  final int? runtime;
  final String? releaseDate;
  final String? status;
  final int? budget;
  final int? revenue;
  final String? tagline;
  final List<CastMember> cast;

  const MovieDetails({
    required this.id,
    required this.title,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.voteAverage,
    this.voteCount,
    this.genres = const [],
    this.runtime,
    this.releaseDate,
    this.status,
    this.budget,
    this.revenue,
    this.tagline,
    this.cast = const [],
  });
}
