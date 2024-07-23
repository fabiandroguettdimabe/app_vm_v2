// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.type.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentTypeDto _$DocumentTypeDtoFromJson(Map<String, dynamic> json) =>
    DocumentTypeDto(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$DocumentTypeDtoToJson(DocumentTypeDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
