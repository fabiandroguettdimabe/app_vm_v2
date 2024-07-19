// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection.method.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectionMethodDto _$CollectionMethodDtoFromJson(Map<String, dynamic> json) =>
    CollectionMethodDto(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$CollectionMethodDtoToJson(
        CollectionMethodDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
