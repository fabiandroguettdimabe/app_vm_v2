// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journey.type.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JourneyTypeDto _$JourneyTypeDtoFromJson(Map<String, dynamic> json) =>
    JourneyTypeDto(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$JourneyTypeDtoToJson(JourneyTypeDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
