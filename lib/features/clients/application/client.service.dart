import 'package:app_vm/constants/dto/response.dto.dart';
import 'package:app_vm/constants/endpoint.data.dart';
import 'package:app_vm/features/clients/domain/client.dto.dart';
import 'package:app_vm/preferences/user.preferences.dart';
import 'package:app_vm/utils/dio.util.dart';

class ClientService {
  static Future<List<ClientDto>?> getClientsByOperations() async {
    var operationId = await UserPreferences.getInt('operationId');
    if (operationId == null) return [];
    var response = await DioUtil.dio.get(endpointClientByOperationMobile,
        queryParameters: {'operationId': operationId});
    if (response.statusCode != 200) return null;
    var apiResponse = ResponseListDto.fromJson(response.data);
    return apiResponse.data?.map((e) => ClientDto.fromJson(e!)).toList();
  }
}