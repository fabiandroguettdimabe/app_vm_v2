// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operation.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OperationDto _$OperationDtoFromJson(Map<String, dynamic> json) => OperationDto(
      id: (json['id'] as num?)?.toInt(),
      name: json['operationName'] as String?,
      supervisorName: json['supervisorName'] as String?,
    );

Map<String, dynamic> _$OperationDtoToJson(OperationDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'operationName': instance.name,
      'supervisorName': instance.supervisorName,
    };
