import 'package:json_annotation/json_annotation.dart';
import 'cast_member_dto.dart';

part 'credits_dto.g.dart';

@JsonSerializable()
class CreditsDto {
  final List<CastMemberDto> cast;

  const CreditsDto({
    required this.cast,
  });

  factory CreditsDto.fromJson(Map<String, dynamic> json) =>
      _$CreditsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreditsDtoToJson(this);
}
