// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceInProcessDto _$ServiceInProcessDtoFromJson(Map<String, dynamic> json) =>
    ServiceInProcessDto(
      id: (json['id'] as num?)?.toInt(),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$ServiceInProcessDtoToJson(
        ServiceInProcessDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
    };

SectionServiceDto _$SectionServiceDtoFromJson(Map<String, dynamic> json) =>
    SectionServiceDto(
      clientIds: (json['clientIds'] as List<dynamic>?)
          ?.map((e) => ClientDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      clientId: json['clientId'] == null
          ? null
          : ClientDto.fromJson(json['clientId'] as Map<String, dynamic>),
      sectionIds: (json['sectionIds'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      sectionId: (json['sectionId'] as num?)?.toInt(),
      originIds: (json['originIds'] as List<dynamic>?)
          ?.map((e) => LocationListDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      destinyIds: (json['destinyIds'] as List<dynamic>?)
          ?.map((e) => LocationListDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      collectionMethodIds: (json['collectionMethodIds'] as List<dynamic>?)
          ?.map((e) => CollectionMethodDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      journeyTypeIds: (json['journeyTypeIds'] as List<dynamic>?)
          ?.map((e) => JourneyTypeDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..originId = json['originId'] == null
          ? null
          : LocationListDto.fromJson(json['originId'] as Map<String, dynamic>)
      ..destinyId = json['destinyId'] == null
          ? null
          : LocationListDto.fromJson(json['destinyId'] as Map<String, dynamic>)
      ..collectionMethodId = json['collectionMethodId'] == null
          ? null
          : CollectionMethodDto.fromJson(
              json['collectionMethodId'] as Map<String, dynamic>)
      ..journeyTypeId = json['journeyTypeId'] == null
          ? null
          : JourneyTypeDto.fromJson(
              json['journeyTypeId'] as Map<String, dynamic>);

Map<String, dynamic> _$SectionServiceDtoToJson(SectionServiceDto instance) =>
    <String, dynamic>{
      'clientIds': instance.clientIds,
      'clientId': instance.clientId,
      'sectionIds': instance.sectionIds,
      'sectionId': instance.sectionId,
      'originIds': instance.originIds,
      'originId': instance.originId,
      'destinyIds': instance.destinyIds,
      'destinyId': instance.destinyId,
      'collectionMethodIds': instance.collectionMethodIds,
      'collectionMethodId': instance.collectionMethodId,
      'journeyTypeIds': instance.journeyTypeIds,
      'journeyTypeId': instance.journeyTypeId,
    };

CreateServiceDto _$CreateServiceDtoFromJson(Map<String, dynamic> json) =>
    CreateServiceDto(
      truckId: (json['initialTruckId'] as num?)?.toInt(),
      originId: (json['originLocationId'] as num?)?.toInt(),
      destinyId: (json['destinyLocationId'] as num?)?.toInt(),
      collectionMethodId: (json['collectionMethodId'] as num?)?.toInt(),
      journeyTypeId: (json['journeyTypeId'] as num?)?.toInt(),
      sectionId: (json['sectionId'] as num?)?.toInt(),
      clientId: (json['clientId'] as num?)?.toInt(),
      createLog: json['createLog'] == null
          ? null
          : LogDto.fromJson(json['createLog'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateServiceDtoToJson(CreateServiceDto instance) =>
    <String, dynamic>{
      'initialTruckId': instance.truckId,
      'originLocationId': instance.originId,
      'destinyLocationId': instance.destinyId,
      'collectionMethodId': instance.collectionMethodId,
      'journeyTypeId': instance.journeyTypeId,
      'sectionId': instance.sectionId,
      'clientId': instance.clientId,
      'createLog': instance.createLog,
    };

ServiceCreatedDto _$ServiceCreatedDtoFromJson(Map<String, dynamic> json) =>
    ServiceCreatedDto(
      serviceId: (json['serviceId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ServiceCreatedDtoToJson(ServiceCreatedDto instance) =>
    <String, dynamic>{
      'serviceId': instance.serviceId,
    };

ServiceShowMobileDto _$ServiceShowMobileDtoFromJson(
        Map<String, dynamic> json) =>
    ServiceShowMobileDto(
      id: (json['id'] as num?)?.toInt(),
      client: json['client'] == null
          ? null
          : ClientDto.fromJson(json['client'] as Map<String, dynamic>),
      originLocation: json['originLocation'] == null
          ? null
          : LocationShowDto.fromJson(
              json['originLocation'] as Map<String, dynamic>),
      destinyLocation: json['destinyLocation'] == null
          ? null
          : LocationShowDto.fromJson(
              json['destinyLocation'] as Map<String, dynamic>),
      collectionMethod: json['collectionMethod'] == null
          ? null
          : CollectionMethodDto.fromJson(
              json['collectionMethod'] as Map<String, dynamic>),
      journeyType: json['journeyType'] == null
          ? null
          : CollectionMethodDto.fromJson(
              json['journeyType'] as Map<String, dynamic>),
      commissionByContainer: json['commissionByContainer'] as bool?,
      containerQty: (json['containerQty'] as num?)?.toInt(),
      lines: (json['serviceLines'] as List<dynamic>?)
          ?.map((e) => ServiceLineShowDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      state: (json['state'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ServiceShowMobileDtoToJson(
        ServiceShowMobileDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'client': instance.client,
      'originLocation': instance.originLocation,
      'destinyLocation': instance.destinyLocation,
      'collectionMethod': instance.collectionMethod,
      'journeyType': instance.journeyType,
      'commissionByContainer': instance.commissionByContainer,
      'containerQty': instance.containerQty,
      'serviceLines': instance.lines,
      'state': instance.state,
    };

ServiceLineShowDto _$ServiceLineShowDtoFromJson(Map<String, dynamic> json) =>
    ServiceLineShowDto(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      weightQuantity: (json['weightQuantity'] as num?)?.toDouble(),
      uomName: json['uomName'] as String?,
      quantity: (json['quantity'] as num?)?.toDouble(),
      guideNumbers: json['guideNumbers'] as String?,
      canEdit: json['canEdit'] as bool?,
      canEditWeight: json['canEditWeight'] as bool?,
    );

Map<String, dynamic> _$ServiceLineShowDtoToJson(ServiceLineShowDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'weightQuantity': instance.weightQuantity,
      'uomName': instance.uomName,
      'quantity': instance.quantity,
      'guideNumbers': instance.guideNumbers,
      'canEdit': instance.canEdit,
      'canEditWeight': instance.canEditWeight,
    };

ServiceLineUpdateDto _$ServiceLineUpdateDtoFromJson(
        Map<String, dynamic> json) =>
    ServiceLineUpdateDto(
      id: (json['id'] as num?)?.toInt(),
      weightQuantity: (json['weightQuantity'] as num?)?.toDouble(),
      quantity: (json['quantity'] as num?)?.toDouble(),
      guideNumbers: json['guideNumbers'] as String?,
    );

Map<String, dynamic> _$ServiceLineUpdateDtoToJson(
        ServiceLineUpdateDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'weightQuantity': instance.weightQuantity,
      'quantity': instance.quantity,
      'guideNumbers': instance.guideNumbers,
    };

ServiceFinishDto _$ServiceFinishDtoFromJson(Map<String, dynamic> json) =>
    ServiceFinishDto(
      serviceId: (json['serviceId'] as num?)?.toInt(),
      truckId: (json['truckId'] as num?)?.toInt(),
      finishLog: json['finishLog'] == null
          ? null
          : LogDto.fromJson(json['finishLog'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ServiceFinishDtoToJson(ServiceFinishDto instance) =>
    <String, dynamic>{
      'serviceId': instance.serviceId,
      'truckId': instance.truckId,
      'finishLog': instance.finishLog,
    };

ServiceDestinyDoneDto _$ServiceDestinyDoneDtoFromJson(
        Map<String, dynamic> json) =>
    ServiceDestinyDoneDto(
      serviceId: (json['serviceId'] as num?)?.toInt(),
      truckId: (json['truckId'] as num?)?.toInt(),
      destinyDoneLog: json['destinyDoneLog'] == null
          ? null
          : LogDto.fromJson(json['destinyDoneLog'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ServiceDestinyDoneDtoToJson(
        ServiceDestinyDoneDto instance) =>
    <String, dynamic>{
      'serviceId': instance.serviceId,
      'truckId': instance.truckId,
      'destinyDoneLog': instance.destinyDoneLog,
    };

ServiceConfirmedDto _$ServiceConfirmedDtoFromJson(Map<String, dynamic> json) =>
    ServiceConfirmedDto(
      id: (json['id'] as num?)?.toInt(),
      description: json['sectionDescription'] as String?,
      client: json['client'] == null
          ? null
          : ClientDto.fromJson(json['client'] as Map<String, dynamic>),
      originLocation: json['origin'] == null
          ? null
          : LocationShowDto.fromJson(json['origin'] as Map<String, dynamic>),
      destinyLocation: json['destiny'] == null
          ? null
          : LocationShowDto.fromJson(json['destiny'] as Map<String, dynamic>),
      collectionMethod: json['collectionMethod'] == null
          ? null
          : CollectionMethodDto.fromJson(
              json['collectionMethod'] as Map<String, dynamic>),
      journeyType: json['journeyType'] == null
          ? null
          : CollectionMethodDto.fromJson(
              json['journeyType'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ServiceConfirmedDtoToJson(
        ServiceConfirmedDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sectionDescription': instance.description,
      'client': instance.client,
      'origin': instance.originLocation,
      'destiny': instance.destinyLocation,
      'collectionMethod': instance.collectionMethod,
      'journeyType': instance.journeyType,
    };

ServiceStartDto _$ServiceStartDtoFromJson(Map<String, dynamic> json) =>
    ServiceStartDto(
      startLog: json['startLog'] == null
          ? null
          : LogDto.fromJson(json['startLog'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ServiceStartDtoToJson(ServiceStartDto instance) =>
    <String, dynamic>{
      'startLog': instance.startLog,
    };
