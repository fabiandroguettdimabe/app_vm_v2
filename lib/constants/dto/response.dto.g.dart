// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseDto _$ResponseDtoFromJson(Map<String, dynamic> json) => ResponseDto(
      statusCode: (json['statusCode'] as num?)?.toInt(),
      message: json['message'] as String?,
      error: json['error'] as String?,
      data: json['data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ResponseDtoToJson(ResponseDto instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'error': instance.error,
      'data': instance.data,
    };

ResponseListDto _$ResponseListDtoFromJson(Map<String, dynamic> json) =>
    ResponseListDto(
      statusCode: (json['statusCode'] as num?)?.toInt(),
      message: json['message'] as String?,
      error: json['error'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>?)
          .toList(),
    );

Map<String, dynamic> _$ResponseListDtoToJson(ResponseListDto instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'error': instance.error,
      'data': instance.data,
    };
