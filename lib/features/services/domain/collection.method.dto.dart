import 'package:json_annotation/json_annotation.dart';

part 'collection.method.dto.g.dart';

@JsonSerializable()
class CollectionMethodDto {
  int? id;
  String? name;

  CollectionMethodDto({
    this.id,
    this.name,
  });

  factory CollectionMethodDto.fromJson(Map<String, dynamic> json) =>
      _$CollectionMethodDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionMethodDtoToJson(this);
}