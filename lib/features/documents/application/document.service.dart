import 'dart:io';

import 'package:app_vm/constants/dto/response.dto.dart';
import 'package:app_vm/constants/endpoint.data.dart';
import 'package:app_vm/features/documents/domain/document.dto.dart';
import 'package:app_vm/utils/dio.util.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';

class DocumentService {
  static Future<List<DocumentDto>> getDocuments(int? serviceLineId) async {
    try {
      var res = await DioUtil.dio.get(endpointDocuments,
          queryParameters: {'serviceLineId': serviceLineId!});
      if (res.statusCode != 200) return [];
      var response = ResponseListDto.fromJson(res.data);
      if (response.statusCode != 200) return [];
      return response.data!.map((e) => DocumentDto.fromJson(e!)).toList();
    } on DioException catch (e) {
      var apiError = ResponseDto.fromJson(e.response!.data!);
      return [];
    }
  }

  static Future<void> uploadCreate(DocumentUploadCreateDto documentUploadCreateDto, List<File?> file) async{
    try {
      var documentsFile = [];
      for (var file in file) {
        var data = MultipartFile.fromFileSync(file!.path, filename: basename(file.path));
        documentsFile.add(data);
      }
      var formData = FormData.fromMap(
        {
          "documentFiles": documentsFile,
          "serviceLineId": documentUploadCreateDto.serviceLineId,
          "documentTypeId": documentUploadCreateDto.documentType!.id,
        },
      );
      await DioUtil.dio.post(endpointDocumentsUpload, data: formData);
    } on DioException catch (e) {
      var errorResponse = ResponseDto.fromJson(e.response!.data!);
    }
  }
}
