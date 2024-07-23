// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentDto _$DocumentDtoFromJson(Map<String, dynamic> json) => DocumentDto(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      documentUrl: json['documentUrl'] as String?,
    );

Map<String, dynamic> _$DocumentDtoToJson(DocumentDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'documentUrl': instance.documentUrl,
    };

DocumentUploadCreateDto _$DocumentUploadCreateDtoFromJson(
        Map<String, dynamic> json) =>
    DocumentUploadCreateDto(
      serviceLineId: (json['serviceLineId'] as num?)?.toInt(),
      documentType: json['documentType'] == null
          ? null
          : DocumentTypeDto.fromJson(
              json['documentType'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DocumentUploadCreateDtoToJson(
        DocumentUploadCreateDto instance) =>
    <String, dynamic>{
      'serviceLineId': instance.serviceLineId,
      'documentType': instance.documentType,
    };
