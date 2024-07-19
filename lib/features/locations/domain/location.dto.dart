import 'package:json_annotation/json_annotation.dart';

part 'location.dto.g.dart';

@JsonSerializable()
class LocationListDto {
  int? id;
  String? name;
  String? address;

  LocationListDto({
    this.id,
    this.name,
    this.address,
  });

  factory LocationListDto.fromJson(Map<String, dynamic> json) =>
      _$LocationListDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LocationListDtoToJson(this);
}

@JsonSerializable()
class LocationShowDto {
  String? name;
  String? address;
  @JsonKey(fromJson: _toDouble)
  double? latitude;
  @JsonKey(fromJson: _toDouble)
  double? longitude;

  LocationShowDto({
    this.name,
    this.address,
    this.latitude,
    this.longitude,
  });

  factory LocationShowDto.fromJson(Map<String, dynamic> json) =>
      _$LocationShowDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LocationShowDtoToJson(this);

  static double _toDouble(String value) {
    return double.parse(value);
  }
}
