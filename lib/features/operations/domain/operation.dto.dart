import 'package:json_annotation/json_annotation.dart';

part 'operation.dto.g.dart';

@JsonSerializable()
class OperationDto {
  int? id;
  @JsonKey(name: 'operationName')
  String? name;
  String? supervisorName;

  OperationDto({
    this.id,
    this.name,
    this.supervisorName,
  });

  factory OperationDto.fromJson(Map<String, dynamic> json) =>
      _$OperationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OperationDtoToJson(this);
}