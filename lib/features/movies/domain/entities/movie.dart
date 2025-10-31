class Movie {
  final int id;
  final String title;
  final String? overview;
  final String? posterPath;
  final double? voteAverage;
  final List<int>? genreIds;

  const Movie({
    required this.id,
    required this.title,
    this.overview,
    this.posterPath,
    this.voteAverage,
    this.genreIds,
  });
}
