// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credits_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditsDto _$CreditsDtoFromJson(Map<String, dynamic> json) => CreditsDto(
      cast: (json['cast'] as List<dynamic>)
          .map((e) => CastMemberDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CreditsDtoToJson(CreditsDto instance) =>
    <String, dynamic>{
      'cast': instance.cast,
    };
