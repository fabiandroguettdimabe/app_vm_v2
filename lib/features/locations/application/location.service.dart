import 'package:app_vm/constants/dto/response.dto.dart';
import 'package:app_vm/constants/endpoint.data.dart';
import 'package:app_vm/features/locations/domain/location.dto.dart';
import 'package:app_vm/utils/dio.util.dart';

class LocationService {
  static Future<List<LocationListDto>?> getOriginLocations(
      int? operationId, int? clientId) async {
    var response = await DioUtil.dio.get(endpointLocationOriginMobile,
        queryParameters: {'operationId': operationId, 'clientId': clientId});
    if (response.statusCode != 200) return null;
    var apiResponse = ResponseListDto.fromJson(response.data);
    return apiResponse.data
        ?.map((json) => LocationListDto.fromJson(json!))
        .toList();
  }

  static Future<List<LocationListDto>?> getDestinyLocations(
      int? operationId, int? clientId, int? originId) async {
    var response = await DioUtil.dio.get(endpointLocationDestinyMobile,
        queryParameters: {'operationId': operationId, 'clientId': clientId, 'originId': originId});
    if (response.statusCode != 200) return null;
    var apiResponse = ResponseListDto.fromJson(response.data);
    return apiResponse.data
        ?.map((json) => LocationListDto.fromJson(json!))
        .toList();
  }
}
