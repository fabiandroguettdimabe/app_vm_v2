import 'package:app_vm/constants/dto/response.dto.dart';
import 'package:app_vm/constants/endpoint.data.dart';
import 'package:app_vm/features/auth/domain/login.dto.dart';
import 'package:app_vm/preferences/user.preferences.dart';
import 'package:app_vm/theme/color.config.dart';
import 'package:app_vm/utils/dio.util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

class AuthService {
  static Future<bool> login(LoginRequestDto model) async {
    try {
      var response = await DioUtil.dio.post(endpointAuth, data: model.toJson());
      if (response.statusCode != 200) return false;

      var apiResponse = ResponseDto.fromJson(response.data['data']);

      if (apiResponse.statusCode != 200) return false;

      var loginDto = LoginResponseDto.fromJson(apiResponse.data!);
      await UserPreferences.login(loginDto);
      return true;
    } on DioException catch (e) {
      var errorResponse = ResponseDto.fromJson(e.response!.data);
      Get.snackbar(
        "Error",
        "Error al iniciar sesión",
        icon: const Icon(FontAwesome.triangle_exclamation_solid),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: errorColorDark,
      );
      return false;
    }
  }

  static Future loginQR(String qrCode) async {
    try {
      final userId = qrCode.split("=")[1];
      var data = {"userId": userId};
      var response = await DioUtil.dio.post(endpointAuthQR, data: data);
      if (response.statusCode != 200) return false;
      var apiResponse = ResponseDto.fromJson(response.data['data']);
      if (apiResponse.statusCode != 200) return false;
      var loginDto = LoginResponseDto.fromJson(apiResponse.data!);
      await UserPreferences.login(loginDto);
      return false;
    } on DioException catch (e) {
      var errorResponse = ResponseDto.fromJson(e.response!.data);
      Get.snackbar(
        "Error",
        "Error al iniciar sesión",
        icon: const Icon(FontAwesome.triangle_exclamation_solid),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: errorColorDark,
      );
      return false;
    } catch (e) {
      Get.snackbar(
        "Error",
        "Error al iniciar sesión",
        icon: const Icon(FontAwesome.triangle_exclamation_solid),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: errorColorDark,
      );
      return false;
    }
  }
}
