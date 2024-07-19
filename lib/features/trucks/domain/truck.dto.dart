import 'package:json_annotation/json_annotation.dart';

part 'truck.dto.g.dart';

@JsonSerializable()
class TruckDto {
  int? id;
  String? patent;
  String? truckNumber;

  TruckDto({this.id, this.patent, this.truckNumber});

  factory TruckDto.fromJson(Map<String, dynamic> json) => _$TruckDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TruckDtoToJson(this);
}