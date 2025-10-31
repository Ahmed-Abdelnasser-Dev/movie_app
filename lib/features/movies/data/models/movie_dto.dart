import 'package:json_annotation/json_annotation.dart';

part 'movie_dto.g.dart';

@JsonSerializable()
class MovieDto {
  final int id;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'original_title')
  final String? originalTitle;
  @JsonKey(name: 'overview')
  final String? overview;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  @JsonKey(name: 'vote_average')
  final double? voteAverage;
  @JsonKey(name: 'genre_ids')
  final List<int>? genreIds;

  MovieDto({
    required this.id,
    this.title,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.voteAverage,
    this.genreIds,
  });

  factory MovieDto.fromJson(Map<String, dynamic> json) =>
      _$MovieDtoFromJson(json);
  Map<String, dynamic> toJson() => _$MovieDtoToJson(this);
}
