import 'package:json_annotation/json_annotation.dart';
import 'genre_dto.dart';

part 'movie_details_dto.g.dart';

@JsonSerializable()
class MovieDetailsDto {
  final int id;
  final String title;
  final String? overview;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  @JsonKey(name: 'vote_average')
  final double? voteAverage;
  @JsonKey(name: 'vote_count')
  final int? voteCount;
  final List<GenreDto> genres;
  final int? runtime;
  @JsonKey(name: 'release_date')
  final String? releaseDate;
  final String? status;
  final int? budget;
  final int? revenue;
  final String? tagline;

  const MovieDetailsDto({
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
  });

  factory MovieDetailsDto.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailsDtoToJson(this);
}
