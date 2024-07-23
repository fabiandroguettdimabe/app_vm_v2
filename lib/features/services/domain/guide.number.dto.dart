import 'package:app_vm/constants/constants.dart';
import 'package:app_vm/constants/endpoint.data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'guide.number.dto.g.dart';

@JsonSerializable()
class GuideNumberDto {
  int? id;
  String? guideNumber;
  String? documentUrl;

  GuideNumberDto({
    this.id,
    this.guideNumber,
  });

  String? get getDocumentUrl {
    return baseUrl + endpointDispatchGuideShow + id.toString() ;
  }

  factory GuideNumberDto.fromJson(Map<String, dynamic> json) =>
      _$GuideNumberDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GuideNumberDtoToJson(this);

}

@JsonSerializable()
class GuideNumberCreateDto {
  int? serviceLineId;
  String? guideNumber;

  GuideNumberCreateDto({
    this.guideNumber,
    this.serviceLineId,
  });

  factory GuideNumberCreateDto.fromJson(Map<String, dynamic> json) =>
      _$GuideNumberCreateDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GuideNumberCreateDtoToJson(this);
}