import 'package:json_annotation/json_annotation.dart';

part 'event.reason.dto.g.dart';

@JsonSerializable()
class EventReasonDto {
  int? id;
  String? name;

  EventReasonDto({
    this.id,
    this.name,
  });

  factory EventReasonDto.fromJson(Map<String, dynamic> json) =>
      _$EventReasonDtoFromJson(json);

  Map<String, dynamic> toJson() => _$EventReasonDtoToJson(this);
}