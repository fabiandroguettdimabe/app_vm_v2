import 'package:app_vm/constants/constants.dart';
import 'package:app_vm/constants/endpoint.data.dart';
import 'package:app_vm/features/documents/domain/document.type.dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'document.dto.g.dart';

@JsonSerializable()
class DocumentDto {
  int? id;
  String? name;
  String? documentUrl;

  DocumentDto({this.id, this.name, this.documentUrl});

  String? get getDocumentUrl {
    return baseUrl + endpointDispatchGuideShow + id.toString() ;
  }


  factory DocumentDto.fromJson(Map<String, dynamic> json) => _$DocumentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentDtoToJson(this);
}

@JsonSerializable()
class DocumentUploadCreateDto {
  int? serviceLineId;
  DocumentTypeDto? documentType;

  DocumentUploadCreateDto({this.serviceLineId, this.documentType});

  factory DocumentUploadCreateDto.fromJson(Map<String, dynamic> json) => _$DocumentUploadCreateDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentUploadCreateDtoToJson(this);
}