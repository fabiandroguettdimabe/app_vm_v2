import 'package:app_vm/constants/dto/response.dto.dart';
import 'package:app_vm/constants/endpoint.data.dart';
import 'package:app_vm/features/services/domain/service.dto.dart';
import 'package:app_vm/utils/dio.util.dart';

class SectionService {
  static Future<SectionServiceDto?> getDataForNewService(
      {int? operationId,
        int? clientId,
        int? originId,
        int? destinyId,
        int? collectionMethod,
        int? journeyTypeId}) async {
    var response = await DioUtil.dio.get(endpointSection, queryParameters: {
      "operationId": operationId,
      "clientId": clientId,
      "originId": originId,
      "destinyId": destinyId,
      "collectionMethod": collectionMethod,
      "journeyTypeId": journeyTypeId
    });
    if (response.statusCode == 200) {
      return SectionServiceDto.fromJson(ResponseDto.fromJson(response.data).data!);
    }
    return null;
  }
}