import 'package:json_annotation/json_annotation.dart';

part 'client.dto.g.dart';

@JsonSerializable()
class ClientDto {
  int? id;
  String? name;

  ClientDto({
    this.id,
    this.name,
  });

  factory ClientDto.fromJson(Map<String, dynamic> json) =>
      _$ClientDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ClientDtoToJson(this);
}