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
  final int? id;
  final ClientDto? client;
  final LocationShowDto? originLocation;
  final LocationShowDto? destinyLocation;
  final CollectionMethodDto? collectionMethod;
  final CollectionMethodDto? journeyType;

  ServiceShowMobileDto({
    this.id,
    this.client,
    this.originLocation,
    this.destinyLocation,
    this.collectionMethod,
    this.journeyType,
  });

  factory ServiceShowMobileDto.fromJson(Map<String, dynamic> json) =>
      _$ServiceShowMobileDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceShowMobileDtoToJson(this);
}
