import 'package:app_vm/constants/dto/response.dto.dart';
import 'package:app_vm/constants/endpoint.data.dart';
import 'package:app_vm/features/trucks/domain/truck.dto.dart';
import 'package:app_vm/theme/color.config.dart';
import 'package:app_vm/utils/dio.util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

class TruckService {
  static Future<List<TruckDto>?> getTrucks() async {
    var response = await DioUtil.dio.get(endpointTruckMobile);
    if (response.statusCode != 200) return null;

    var apiResponse = ResponseListDto.fromJson(response.data);

    if (apiResponse.statusCode != 200) {
      Get.showSnackbar(GetSnackBar(
        title: 'Error',
        message: apiResponse.error!,
        snackPosition: SnackPosition.BOTTOM,
      ));
    }
    if (apiResponse.statusCode == 200) {
      var trucks = <TruckDto>[];
      for (var truck in apiResponse.data!) {
        trucks.add(TruckDto.fromJson(truck!));
      }
      return trucks;
    }

    return null;
  }

  static Future<TruckDto?> getTruckByPatent(String? patent) async {
    try {
      var response = await DioUtil.dio
          .get(endpointTruckByPatent, queryParameters: {'patent': patent});
      if (response.statusCode != 200) return null;
      var apiResponse = ResponseDto.fromJson(response.data);
      if (apiResponse.statusCode != 200) return null;
      return TruckDto.fromJson(apiResponse.data!);
    } on DioException catch (e) {
      var errorResponse = ResponseDto.fromJson(e.response?.data);
      Get.snackbar(
        'Error',
        errorResponse.error!,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: errorColorDark,
        icon: const Icon(FontAwesome.triangle_exclamation_solid),
      );
      return null;
    }
  }
}
