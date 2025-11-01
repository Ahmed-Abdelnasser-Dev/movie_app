import 'package:json_annotation/json_annotation.dart';

part 'cast_member_dto.g.dart';

@JsonSerializable()
class CastMemberDto {
  final int id;
  final String name;
  final String character;
  @JsonKey(name: 'profile_path')
  final String? profilePath;

  const CastMemberDto({
    required this.id,
    required this.name,
    required this.character,
    this.profilePath,
  });

  factory CastMemberDto.fromJson(Map<String, dynamic> json) =>
      _$CastMemberDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CastMemberDtoToJson(this);
}
