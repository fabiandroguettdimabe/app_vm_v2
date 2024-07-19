import 'package:app_vm/utils/string.util.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login.dto.g.dart';

@JsonSerializable()
class LoginRequestDto {
  @JsonKey(name: 'userName', toJson: _toJsonVat)
  String? vat;
  @JsonKey(name: 'userPassword')
  String? password;

  LoginRequestDto({this.vat, this.password});

  static _toJsonVat(String? value) {
    var rut = value?.replaceAll('.', '').replaceAll('-', '') ?? '';
    if (rut != ''){
      return replaceLastChar(rut, "-${rut[rut.length - 1]}");
    }
    return rut;
  }

  factory LoginRequestDto.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestDtoToJson(this);
}

@JsonSerializable()
class LoginResponseDto {
  String? userId;
  String? userName;
  String? userEmail;
  String? userFullName;
  String? accessToken;
  String? refreshToken;

  LoginResponseDto({
    this.userId,
    this.userName,
    this.userEmail,
    this.userFullName,
    this.accessToken,
    this.refreshToken,
  });

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseDtoToJson(this);
}
