import 'package:json_annotation/json_annotation.dart';

part 'document.type.dto.g.dart';

@JsonSerializable()
class DocumentTypeDto {
  int? id;
  String? name;

  DocumentTypeDto({
    this.id,
    this.name,
  });

  factory DocumentTypeDto.fromJson(Map<String, dynamic> json) =>
      _$DocumentTypeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentTypeDtoToJson(this);
}
