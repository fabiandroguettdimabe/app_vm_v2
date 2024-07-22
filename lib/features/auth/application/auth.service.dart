import 'package:app_vm/constants/dto/response.dto.dart';
import 'package:app_vm/constants/endpoint.data.dart';
import 'package:app_vm/features/auth/domain/login.dto.dart';
import 'package:app_vm/preferences/user.preferences.dart';
import 'package:app_vm/utils/dio.util.dart';

class AuthService {
  static Future<bool> login(LoginRequestDto model) async {
    var response = await DioUtil.dio.post(endpointAuth, data: model.toJson());
    if (response.statusCode != 200) return false;

    var apiResponse = ResponseDto.fromJson(response.data['data']);

    if (apiResponse.statusCode != 200) return false;

    var loginDto = LoginResponseDto.fromJson(apiResponse.data!);
    await UserPreferences.login(loginDto);
    return true;
  }
  static Future loginQR(String qrCode) async {
    final userId = qrCode.split("=")[1];
    var data = {"userId": userId};
    var response = await DioUtil.dio.post(endpointAuthQR, data: data);
    if (response.statusCode != 200) return false;
    var apiResponse = ResponseDto.fromJson(response.data['data']);
    if (apiResponse.statusCode != 200) return false;
    var loginDto = LoginResponseDto.fromJson(apiResponse.data!);
    await UserPreferences.login(loginDto);
    return false;
  }
}
