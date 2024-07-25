import 'dart:io';

import 'package:app_vm/constants/dto/response.dto.dart';
import 'package:app_vm/constants/endpoint.data.dart';
import 'package:app_vm/features/services/domain/service.dto.dart';
import 'package:app_vm/theme/color.config.dart';
import 'package:app_vm/utils/dio.util.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:get/get.dart';
import 'package:path/path.dart';

class ServiceService {
  // Services
  static Future<void> createService(CreateServiceDto model) async {
    try {
      var response =
          await DioUtil.dio.post(endpointService, data: model.toJson());
      if (response.statusCode != 200) {
        return null;
      }
      var apiResponse = ResponseDto.fromJson(response.data);
      if (apiResponse.statusCode != 200) return null;
      var serviceCreated = ServiceCreatedDto.fromJson(apiResponse.data!);
      Get.toNamed('/service', arguments: {'id': serviceCreated.serviceId!});
    } on Dio.DioException catch (e) {
      var errorResponse = ResponseDto.fromJson(e.response?.data);
      if (errorResponse.statusCode == 400) {
        Get.snackbar('Error', errorResponse.message!,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: errorColorDark);
      }
    }
  }

  static Future<List<ServiceConfirmedDto>?> getServicesConfirmed() async {
    try {
      var response = await DioUtil.dio.get(endpointServiceConfirmed);
      if (response.statusCode != 200) return [];
      var apiResponse = ResponseListDto.fromJson(response.data);
      if (apiResponse.statusCode != 200) return [];
      return apiResponse.data!
          .map((e) => ServiceConfirmedDto.fromJson(e!))
          .toList();
    } on Dio.DioException catch (e) {
      var errorResponse = ResponseDto.fromJson(e.response?.data);
      if (errorResponse.statusCode == 404) {
        return [];
      }
      return null;
    }
  }

  static Future<List<ServiceRelievedDto>?> getServicesRelieved() async {
    try {
      var response = await DioUtil.dio.get(endpointServiceRelieved);
      if (response.statusCode != 200) return [];
      var apiResponse = ResponseListDto.fromJson(response.data);
      if (apiResponse.statusCode != 200) return [];
      return apiResponse.data!
          .map((e) => ServiceRelievedDto.fromJson(e!))
          .toList();
    } on Dio.DioException catch (e) {
      var errorResponse = ResponseDto.fromJson(e.response?.data);
      if (errorResponse.statusCode == 404) {
        return [];
      }
      return null;
    }
  }

  static Future<ServiceShowMobileDto?> getService(int id) async {
    var response = await DioUtil.dio
        .get(endpointServiceShow, queryParameters: {'serviceId': id});
    if (response.statusCode != 200) return null;
    var apiResponse = ResponseDto.fromJson(response.data);
    if (apiResponse.statusCode != 200) return null;
    return ServiceShowMobileDto.fromJson(apiResponse.data!);
  }

  static Future<List<ServiceInProcessDto>?> getServicesInProcess() async {
    var response = await DioUtil.dio.get(endpointUserServiceInProcess);
    if (response.statusCode != 200) return null;
    var apiResponse = ResponseListDto.fromJson(response.data);
    if (apiResponse.statusCode != 200) return null;
    return apiResponse.data
        ?.map((e) => ServiceInProcessDto.fromJson(e!))
        .toList();
  }

  static Future<int?> getQtyServiceInProcess() async {
    var response = await DioUtil.dio.get(endpointQtyUserServiceInProcess);
    if (response.statusCode != 200) return null;
    var apiResponse = ResponseDto.fromJson(response.data);
    if (!apiResponse.data!.containsKey('quantity')) return 0;
    if (apiResponse.statusCode != 200) return null;
    return apiResponse.data!['quantity'] as int ?? 0;
  }

  static Future<void> startService(int? serviceId, ServiceStartDto dto) async {
    try {
      var response = await DioUtil.dio.put(endpointServiceStart,
          queryParameters: {'serviceId': serviceId}, data: dto.toJson());
      if (response.statusCode != 200) return;
      var apiResponse = ResponseDto.fromJson(response.data);
      if (apiResponse.statusCode != 200) return;
      var serviceStartedId = apiResponse.data!['serviceId'] as int;
      Get.offNamed('/service', arguments: {'id': serviceStartedId});
    } on Dio.DioException catch (e) {
      var errorResponse = ResponseDto.fromJson(e.response?.data);
      if (errorResponse.statusCode == 400) {
        Get.snackbar('Error', errorResponse.message!,snackPosition: SnackPosition.BOTTOM, backgroundColor: errorColorDark);
      }
    }
    return null;
  }

  static Future<void> finishService(ServiceFinishDto dto) async {
    try {
      var response =
          await DioUtil.dio.put(endpointServiceFinish, data: dto.toJson());
      if (response.statusCode != 200) return null;
      var apiResponse = ResponseDto.fromJson(response.data);
      if (apiResponse.statusCode != 200) return null;
      Get.offNamed('/');
    } on Dio.DioException catch (e) {
      var errorResponse = ResponseDto.fromJson(e.response?.data);
      if (errorResponse.statusCode == 400) {
        Get.snackbar('Error', errorResponse.message!,snackPosition: SnackPosition.BOTTOM,
          backgroundColor: errorColorDark,);
      }
    }
  }

  static Future<void> destinyDoneService(ServiceDestinyDoneDto dto) async {
    try {
      var response =
          await DioUtil.dio.put(endpointServiceDestinyDone, data: dto.toJson());
      if (response.statusCode != 200) return null;
      var apiResponse = ResponseDto.fromJson(response.data);
      if (apiResponse.statusCode != 200) return null;
      Get.back();
    } on Dio.DioException catch (e) {
      var errorResponse = ResponseDto.fromJson(e.response?.data);
      if (errorResponse.statusCode == 400) {
        Get.snackbar('Error', errorResponse.message!,snackPosition: SnackPosition.BOTTOM,
          backgroundColor: errorColorDark,);
      }
    }
  }

  static Future<void> cancelService(
      int? serviceId, ServiceCancelDto dto) async {
    try {
      var response = await DioUtil.dio.put(endpointServiceCancel,
          data: dto.toJson(), queryParameters: {'serviceId': serviceId});
      if (response.statusCode != 200) return null;
      var apiResponse = ResponseDto.fromJson(response.data);
      if (apiResponse.statusCode != 200) return null;
      Get.offNamed('/');
    } on Dio.DioException catch (e) {
      var errorResponse = ResponseDto.fromJson(e.response?.data);
      if (errorResponse.statusCode == 400) {
        Get.snackbar('Error', errorResponse.message!,snackPosition: SnackPosition.BOTTOM,
          backgroundColor: errorColorDark,);
      }
    }
  }

  static Future<void> releaseService(
      int? id, ServiceReleaseDto release, List<File> files) async {
    try {
      var documentsFile = [];
      for (var file in files) {
        var data = Dio.MultipartFile.fromFileSync(file!.path,
            filename: basename(file.path));
        documentsFile.add(data);
      }
      var formData = Dio.FormData.fromMap(
        {
          "documentFiles": documentsFile,
          "logMobile": release.releaseLog!.toJson(),
          "observation": release.observation,
          "eventReasonId": release.eventReasonId,
        },
      );
      var response = await DioUtil.dio.put(endpointServiceRelease,
          data: formData, queryParameters: {'serviceId': id});
      if (response.statusCode != 200) return null;
      var apiResponse = ResponseDto.fromJson(response.data);
      if (apiResponse.statusCode != 200) return null;
      Get.offNamed('/');
    } on Dio.DioException catch (e) {
      var errorResponse = ResponseDto.fromJson(e.response?.data);
      if (errorResponse.statusCode == 400) {
        Get.snackbar('Error', errorResponse.message!,snackPosition: SnackPosition.BOTTOM,
          backgroundColor: errorColorDark,);
      }
    }
  }

  static Future<void> takeOverService(int? id) async {
    try {
      var response = await DioUtil.dio
          .put(endpointServiceTakeOver, queryParameters: {'serviceId': id});
      if (response.statusCode != 200) return null;
      var apiResponse = ResponseDto.fromJson(response.data);
      if (apiResponse.statusCode != 200) return null;
      Get.offNamed('/service', arguments: {'id': id});
    } on Dio.DioException catch (e) {
      var errorResponse = ResponseDto.fromJson(e.response?.data);
      if (errorResponse.statusCode == 400) {
        Get.snackbar('Error', errorResponse.message!,snackPosition: SnackPosition.BOTTOM,
          backgroundColor: errorColorDark,);
      }
    }
  }


  static Future<List<ServiceFinishedDto>?> getFinishedService(
      int? month) async {
    try {
      var response = await DioUtil.dio
          .get(endpointServiceFinished, queryParameters: {'month': month});
      if (response.statusCode != 200) return null;
      var apiResponse = ResponseListDto.fromJson(response.data);
      if (apiResponse.statusCode != 200) return null;
      return apiResponse.data!
          .map((e) => ServiceFinishedDto.fromJson(e!))
          .toList();
    } on Dio.DioException catch (e) {
      var errorResponse = ResponseDto.fromJson(e.response?.data);
      if (errorResponse.statusCode == 404) {
        return [];
      }
      return null;
    }
  }

  // Services Lines
  static Future<void> updateServiceLine(ServiceLineUpdateDto model) async {
    try {
      var response = await DioUtil.dio
          .put(endpointServiceUpdateLine, data: model.toJson());
      if (response.statusCode != 200) return null;
      var apiResponse = ResponseDto.fromJson(response.data);
      if (apiResponse.statusCode != 200) return null;
      Get.back();
    } on Dio.DioException catch (e) {
      var errorResponse = ResponseDto.fromJson(e.response?.data);
      if (errorResponse.statusCode == 400) {
        Get.snackbar('Error', errorResponse.message!,snackPosition: SnackPosition.BOTTOM,
          backgroundColor: errorColorDark,);
      }
    }
  }
}
