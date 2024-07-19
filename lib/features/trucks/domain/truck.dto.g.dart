// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'truck.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TruckDto _$TruckDtoFromJson(Map<String, dynamic> json) => TruckDto(
      id: (json['id'] as num?)?.toInt(),
      patent: json['patent'] as String?,
      truckNumber: json['truckNumber'] as String?,
    );

Map<String, dynamic> _$TruckDtoToJson(TruckDto instance) => <String, dynamic>{
      'id': instance.id,
      'patent': instance.patent,
      'truckNumber': instance.truckNumber,
    };
