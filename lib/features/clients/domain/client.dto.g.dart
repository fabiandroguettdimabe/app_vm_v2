// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientDto _$ClientDtoFromJson(Map<String, dynamic> json) => ClientDto(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ClientDtoToJson(ClientDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
