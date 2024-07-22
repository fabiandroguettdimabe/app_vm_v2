import 'package:app_vm/constants/dto/response.dto.dart';
import 'package:app_vm/constants/endpoint.data.dart';
import 'package:app_vm/features/services/domain/service.dto.dart';
import 'package:app_vm/utils/dio.util.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

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
    } on DioException catch (e) {
      var errorResponse = ResponseDto.fromJson(e.response?.data);
      if (errorResponse.statusCode == 400) {
        Get.snackbar('Error', errorResponse.message!);
      }
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

  static Future<void> finishService(ServiceFinishDto dto) async {
    try {
      var response =
          await DioUtil.dio.put(endpointServiceFinish, data: dto.toJson());
      if (response.statusCode != 200) return null;
      var apiResponse = ResponseDto.fromJson(response.data);
      if (apiResponse.statusCode != 200) return null;
      Get.offNamed('/');
    } on DioException catch (e) {
      var errorResponse = ResponseDto.fromJson(e.response?.data);
      if (errorResponse.statusCode == 400) {
        Get.snackbar('Error', errorResponse.message!);
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
    } on DioException catch (e) {
      var errorResponse = ResponseDto.fromJson(e.response?.data);
      if (errorResponse.statusCode == 400) {
        Get.snackbar('Error', errorResponse.message!);
      }
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
    } on DioException catch (e) {
      var errorResponse = ResponseDto.fromJson(e.response?.data);
      if (errorResponse.statusCode == 400) {
        Get.snackbar('Error', errorResponse.message!);
      }
    }
  }
}
