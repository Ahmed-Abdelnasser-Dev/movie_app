import 'package:json_annotation/json_annotation.dart';
import 'movie_dto.dart';

part 'movies_response_dto.g.dart';

@JsonSerializable()
class MoviesResponseDto {
  final int page;
  final List<MovieDto> results;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @JsonKey(name: 'total_results')
  final int totalResults;

  MoviesResponseDto({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MoviesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MoviesResponseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$MoviesResponseDtoToJson(this);
}
