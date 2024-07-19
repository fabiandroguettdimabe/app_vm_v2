import 'package:json_annotation/json_annotation.dart';

part 'log.dto.g.dart';

@JsonSerializable()
class LogDto {
  @JsonKey(name: 'latitude', toJson: _toJsonLatitude)
  double? latitude;
  @JsonKey(name: 'longitude', toJson: _toJsonLongitude)
  double? longitude;

  LogDto({
    this.latitude,
    this.longitude,
  });

  factory LogDto.fromJson(Map<String, dynamic> json) => _$LogDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LogDtoToJson(this);

  static String? _toJsonLatitude(double? value) => value.toString();

  static String? _toJsonLongitude(double? value) => value.toString();
}
