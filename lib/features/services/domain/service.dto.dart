import 'package:app_vm/features/clients/domain/client.dto.dart';
import 'package:app_vm/features/locations/domain/location.dto.dart';
import 'package:app_vm/features/services/domain/collection.method.dto.dart';
import 'package:app_vm/features/services/domain/journey.type.dto.dart';
import 'package:app_vm/features/services/domain/log.dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'service.dto.g.dart';

@JsonSerializable()
class ServiceInProcessDto {
  int? id;
  String? description;

  ServiceInProcessDto({
    this.id,
    this.description,
  });

  factory ServiceInProcessDto.fromJson(Map<String, dynamic> json) =>
      _$ServiceInProcessDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceInProcessDtoToJson(this);
}

@JsonSerializable()
class SectionServiceDto {
  List<ClientDto>? clientIds;
  ClientDto? clientId;
  List<int>? sectionIds;
  int? sectionId;
  List<LocationListDto>? originIds;
  LocationListDto? originId;
  List<LocationListDto>? destinyIds;
  LocationListDto? destinyId;
  List<CollectionMethodDto>? collectionMethodIds;
  CollectionMethodDto? collectionMethodId;
  List<JourneyTypeDto>? journeyTypeIds;
  JourneyTypeDto? journeyTypeId;

  SectionServiceDto({
    this.clientIds,
    this.clientId,
    this.sectionIds,
    this.sectionId,
    this.originIds,
    this.destinyIds,
    this.collectionMethodIds,
    this.journeyTypeIds,
  });

  factory SectionServiceDto.fromJson(Map<String, dynamic> json) =>
      _$SectionServiceDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SectionServiceDtoToJson(this);
}

@JsonSerializable()
class CreateServiceDto {
  @JsonKey(name: 'initialTruckId')
  int? truckId;
  @JsonKey(name: 'originLocationId')
  int? originId;
  @JsonKey(name: 'destinyLocationId')
  int? destinyId;
  @JsonKey(name: 'collectionMethodId')
  int? collectionMethodId;
  @JsonKey(name: 'journeyTypeId')
  int? journeyTypeId;
  @JsonKey(name: 'sectionId')
  int? sectionId;
  @JsonKey(name: 'clientId')
  int? clientId;
  @JsonKey(name: 'createLog')
  LogDto? createLog;

  CreateServiceDto(
      {this.truckId,
      this.originId,
      this.destinyId,
      this.collectionMethodId,
      this.journeyTypeId,
      this.sectionId,
      this.clientId,
      this.createLog});

  factory CreateServiceDto.fromJson(Map<String, dynamic> json) =>
      _$CreateServiceDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateServiceDtoToJson(this);
}

@JsonSerializable()
class ServiceCreatedDto {
  int? serviceId;

  ServiceCreatedDto({
    this.serviceId,
  });

  factory ServiceCreatedDto.fromJson(Map<String, dynamic> json) =>
      _$ServiceCreatedDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceCreatedDtoToJson(this);
}

@JsonSerializable()
class ServiceShowMobileDto {
  int? id;
  ClientDto? client;
  LocationShowDto? originLocation;
  LocationShowDto? destinyLocation;
  CollectionMethodDto? collectionMethod;
  CollectionMethodDto? journeyType;
  bool? commissionByContainer;
  int? containerQty;
  @JsonKey(name: "serviceLines")
  List<ServiceLineShowDto>? lines;
  int? state;

  ServiceShowMobileDto(
      {this.id,
      this.client,
      this.originLocation,
      this.destinyLocation,
      this.collectionMethod,
      this.journeyType,
      this.commissionByContainer,
      this.containerQty,
      this.lines,
      this.state});

  factory ServiceShowMobileDto.fromJson(Map<String, dynamic> json) =>
      _$ServiceShowMobileDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceShowMobileDtoToJson(this);
}

@JsonSerializable()
class ServiceLineShowDto {
  int? id;
  String? title;
  double? weightQuantity;
  String? uomName;
  double? quantity;
  String? guideNumbers;
  bool? canEdit;
  bool? canEditWeight;

  ServiceLineShowDto(
      {this.id,
      this.title,
      this.weightQuantity,
      this.uomName,
      this.quantity,
      this.guideNumbers,
      this.canEdit,
      this.canEditWeight});

  factory ServiceLineShowDto.fromJson(Map<String, dynamic> json) =>
      _$ServiceLineShowDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceLineShowDtoToJson(this);
}

@JsonSerializable()
class ServiceLineUpdateDto {
  int? id;
  double? weightQuantity;
  double? quantity;
  String? guideNumbers;

  ServiceLineUpdateDto(
      {this.id, this.weightQuantity, this.quantity, this.guideNumbers});

  factory ServiceLineUpdateDto.fromJson(Map<String, dynamic> json) =>
      _$ServiceLineUpdateDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceLineUpdateDtoToJson(this);
}

@JsonSerializable()
class ServiceFinishDto {
  int? serviceId;
  int? truckId;
  LogDto? finishLog;

  ServiceFinishDto({this.serviceId,this.truckId, this.finishLog});

  factory ServiceFinishDto.fromJson(Map<String, dynamic> json) =>
      _$ServiceFinishDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceFinishDtoToJson(this);
}

@JsonSerializable()
class ServiceDestinyDoneDto {
  int? serviceId;
  int? truckId;
  LogDto? destinyDoneLog;

  ServiceDestinyDoneDto({this.serviceId,this.truckId, this.destinyDoneLog});

  factory ServiceDestinyDoneDto.fromJson(Map<String, dynamic> json) =>
      _$ServiceDestinyDoneDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceDestinyDoneDtoToJson(this);
}

@JsonSerializable()
class ServiceConfirmedDto {
  int? id;
  @JsonKey(name: 'sectionDescription')
  String? description;
  ClientDto? client;
  @JsonKey(name: 'origin')
  LocationShowDto? originLocation;
  @JsonKey(name: 'destiny')
  LocationShowDto? destinyLocation;
  CollectionMethodDto? collectionMethod;
  CollectionMethodDto? journeyType;

  ServiceConfirmedDto(
      {this.id,
      this.description,
      this.client,
      this.originLocation,
      this.destinyLocation,
      this.collectionMethod,
      this.journeyType});

  factory ServiceConfirmedDto.fromJson(Map<String, dynamic> json) =>
      _$ServiceConfirmedDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceConfirmedDtoToJson(this);

}

@JsonSerializable()
class ServiceStartDto {
  LogDto? startLog;

  ServiceStartDto({this.startLog});

  factory ServiceStartDto.fromJson(Map<String, dynamic> json) =>
      _$ServiceStartDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceStartDtoToJson(this);
}