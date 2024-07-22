// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guide.number.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuideNumberDto _$GuideNumberDtoFromJson(Map<String, dynamic> json) =>
    GuideNumberDto(
      id: (json['id'] as num?)?.toInt(),
      guideNumber: json['guideNumber'] as String?,
      documentUrl: json['documentUrl'] as String?,
    );

Map<String, dynamic> _$GuideNumberDtoToJson(GuideNumberDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'guideNumber': instance.guideNumber,
      'documentUrl': instance.documentUrl,
    };

GuideNumberCreateDto _$GuideNumberCreateDtoFromJson(
        Map<String, dynamic> json) =>
    GuideNumberCreateDto(
      guideNumber: json['guideNumber'] as String?,
      serviceLineId: (json['serviceLineId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GuideNumberCreateDtoToJson(
        GuideNumberCreateDto instance) =>
    <String, dynamic>{
      'serviceLineId': instance.serviceLineId,
      'guideNumber': instance.guideNumber,
    };
