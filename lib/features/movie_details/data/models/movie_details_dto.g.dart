// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetailsDto _$MovieDetailsDtoFromJson(Map<String, dynamic> json) =>
    MovieDetailsDto(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: (json['vote_count'] as num?)?.toInt(),
      genres: (json['genres'] as List<dynamic>?)
              ?.map((e) => GenreDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      runtime: (json['runtime'] as num?)?.toInt(),
      releaseDate: json['release_date'] as String?,
      status: json['status'] as String?,
      budget: (json['budget'] as num?)?.toInt(),
      revenue: (json['revenue'] as num?)?.toInt(),
      tagline: json['tagline'] as String?,
    );

Map<String, dynamic> _$MovieDetailsDtoToJson(MovieDetailsDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'overview': instance.overview,
      'poster_path': instance.posterPath,
      'backdrop_path': instance.backdropPath,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'genres': instance.genres,
      'runtime': instance.runtime,
      'release_date': instance.releaseDate,
      'status': instance.status,
      'budget': instance.budget,
      'revenue': instance.revenue,
      'tagline': instance.tagline,
    };
