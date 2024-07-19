import 'package:json_annotation/json_annotation.dart';

part 'journey.type.dto.g.dart';

@JsonSerializable()
class JourneyTypeDto {
  int? id;
  String? name;

  JourneyTypeDto({
    this.id,
    this.name,
  });

  factory JourneyTypeDto.fromJson(Map<String, dynamic> json) =>
      _$JourneyTypeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$JourneyTypeDtoToJson(this);
}
