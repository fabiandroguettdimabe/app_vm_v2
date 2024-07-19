import 'package:app_vm/constants/dto/response.dto.dart';
import 'package:app_vm/constants/endpoint.data.dart';
import 'package:app_vm/features/operations/domain/operation.dto.dart';
import 'package:app_vm/utils/dio.util.dart';

class OperationService {
  static Future<List<OperationDto>?> getOperations() async {
    var response = await DioUtil.dio.get(endpointOperationMobile);
    if (response.statusCode != 200) return null;
    var apiResponse = ResponseListDto.fromJson(response.data);
    return apiResponse.data?.map((operation) => OperationDto.fromJson(operation!)).toList();
  }
}