import 'dart:io';

import 'package:app_vm/constants/dto/response.dto.dart';
import 'package:app_vm/constants/endpoint.data.dart';
import 'package:app_vm/features/services/domain/guide.number.dto.dart';
import 'package:app_vm/features/services/domain/log.dto.dart';
import 'package:app_vm/theme/color.config.dart';
import 'package:app_vm/utils/dio.util.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:get/get.dart';
import 'package:path/path.dart';

class DispatchGuideService {
  static Future<List<GuideNumberDto>> getGuidesByServiceLineId(
      int? serviceLineId) async {
    var response = await DioUtil.dio.get(endpointServiceLineDispatchGuide,
        queryParameters: {'serviceLineId': serviceLineId});
    if (response.statusCode != 200) return [];
    var apiResponse = ResponseListDto.fromJson(response.data);
    if (apiResponse.statusCode != 200) return [];
    return apiResponse.data?.map((e) => GuideNumberDto.fromJson(e!)).toList() ??
        [];
  }

  static Future<void> createGuideNumber(
      GuideNumberCreateDto guideNumberCreateDto, List<File>? files) async {
     try {
       Dio.MultipartFile? file;
       var documentsFile = [];
       for (var file in files!) {
         var data = await Dio.MultipartFile.fromFile(file.path,
             filename: basename(file.path));
         documentsFile.add(data);
       }
       var formData = Dio.FormData.fromMap(
         {
           "documentFiles": documentsFile,
           "dispatchGuide": guideNumberCreateDto.guideNumber,
           "serviceLineId": guideNumberCreateDto.serviceLineId,
         },
       );
       var res = await DioUtil.dio.post(endpointDocumentsDispatchGuide,
           data: formData);
     } on Dio.DioException catch (e) {
        var errorResponse = ResponseDto.fromJson(e.response!.data);
        Get.snackbar("Error al subir guia", errorResponse.message!, snackPosition: SnackPosition.BOTTOM, backgroundColor: errorColorDark);

     }
  }

  static Future<void> deleteGuideNumber(int? id) async {
    try {
      var response = await DioUtil.dio.delete(endpointDispatchGuideDelete,
          queryParameters: {'dispatchGuideId': id});
      if (response.statusCode != 200) return null;
      var apiResponse = ResponseDto.fromJson(response.data);
      if (apiResponse.statusCode != 200) return null;
      Get.back();
    } on Dio.DioException catch (e) {
      var errorResponse = ResponseDto.fromJson(e.response!.data);
      Get.snackbar("Error al eliminar guia", errorResponse.message!, snackPosition: SnackPosition.BOTTOM, backgroundColor: errorColorDark);
    }
  }
}
