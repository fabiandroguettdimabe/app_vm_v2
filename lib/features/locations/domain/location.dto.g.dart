// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationListDto _$LocationListDtoFromJson(Map<String, dynamic> json) =>
    LocationListDto(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$LocationListDtoToJson(LocationListDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
    };

LocationShowDto _$LocationShowDtoFromJson(Map<String, dynamic> json) =>
    LocationShowDto(
      name: json['name'] as String?,
      address: json['address'] as String?,
      latitude: LocationShowDto._toDouble(json['latitude'] as String),
      longitude: LocationShowDto._toDouble(json['longitude'] as String),
    );

Map<String, dynamic> _$LocationShowDtoToJson(LocationShowDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
