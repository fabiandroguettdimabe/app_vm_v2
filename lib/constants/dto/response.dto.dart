import 'package:json_annotation/json_annotation.dart';

part 'response.dto.g.dart';

@JsonSerializable()
class ResponseDto {
  int? statusCode;
  String? message;
  String? error;
  Map<String, dynamic>? data;

  ResponseDto({this.statusCode, this.message, this.error, this.data});

  factory ResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseDtoToJson(this);

}

@JsonSerializable()
class ResponseListDto {
  int? statusCode;
  String? message;
  String? error;
  List<Map<String, dynamic>?>? data;

  ResponseListDto({this.statusCode, this.message, this.error, this.data});

  factory ResponseListDto.fromJson(Map<String, dynamic> json) =>
      _$ResponseListDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseListDtoToJson(this);

}
