// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.reason.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventReasonDto _$EventReasonDtoFromJson(Map<String, dynamic> json) =>
    EventReasonDto(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$EventReasonDtoToJson(EventReasonDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
