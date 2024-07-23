import 'package:app_vm/constants/dto/response.dto.dart';
import 'package:app_vm/constants/endpoint.data.dart';
import 'package:app_vm/features/documents/domain/document.type.dto.dart';
import 'package:app_vm/utils/dio.util.dart';

class DocumentTypeService {
  static Future<List<DocumentTypeDto>?> getDocumentTypes() async {
    var response = await DioUtil.dio.get(endpointDocumentTypes);
    if (response.statusCode != 200) return [];
    var apiResponse = ResponseListDto.fromJson(response.data);
    if (apiResponse.data == null) return [];
    return apiResponse.data?.map((e) => DocumentTypeDto.fromJson(e!)).toList();
  }
}
