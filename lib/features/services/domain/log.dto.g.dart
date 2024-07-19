// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogDto _$LogDtoFromJson(Map<String, dynamic> json) => LogDto(
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$LogDtoToJson(LogDto instance) => <String, dynamic>{
      'latitude': LogDto._toJsonLatitude(instance.latitude),
      'longitude': LogDto._toJsonLongitude(instance.longitude),
    };
