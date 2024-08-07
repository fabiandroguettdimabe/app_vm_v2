import 'package:app_vm/constants/dto/type.event.dto.dart';
import 'package:app_vm/features/clients/domain/client.dto.dart';
import 'package:app_vm/features/documents/domain/document.type.dto.dart';
import 'package:app_vm/features/event_reasons/domain/event.reason.dto.dart';
import 'package:app_vm/features/locations/domain/location.dto.dart';
import 'package:app_vm/features/services/domain/collection.method.dto.dart';
import 'package:app_vm/features/services/domain/journey.type.dto.dart';
import 'package:app_vm/features/trucks/domain/truck.dto.dart';
import 'package:flutter_awesome_select_clone/flutter_awesome_select.dart';

import '../features/operations/domain/operation.dto.dart';

choiceTrucks(List<TruckDto>? trucks) {
  return trucks
          ?.map((truck) => S2Choice(
                value: truck,
                title: truck.patent,
                subtitle: "N - ${truck.truckNumber}",
              ))
          .toList() ??
      <S2Choice<TruckDto?>>[];
}

choiceOperations(List<OperationDto>? operations) {
  return operations
      ?.map((operation) => S2Choice(
            value: operation,
            title: operation.name,
            subtitle: "Supervisor ${operation.supervisorName}",
          ))
      .toList();
}

choiceClients(List<ClientDto>? clients) {
  return clients
      ?.map((client) => S2Choice(
            value: client,
            title: client.name ?? "",
          ))
      .toList();
}

choiceLocations(List<LocationListDto>? locations) {
  return locations
      ?.map(
        (location) => S2Choice(
          value: location,
          title: location.name ?? "",
          subtitle: location.address ?? "",
        ),
      )
      .toList();
}

choiceCollectionMethods(List<CollectionMethodDto>? collectionMethods) {
  return collectionMethods
      ?.map(
        (collectionMethod) => S2Choice(
          value: collectionMethod,
          title: collectionMethod.name ?? "",
        ),
      )
      .toList();
}

choiceJourneyType(List<JourneyTypeDto>? journeyTypes) {

  return journeyTypes
      ?.map(
        (journeyType) => S2Choice(
          value: journeyType,
          title: journeyType.name ?? "",
        ),
      )
      .toList();
}

choiceDocumentTypes(List<DocumentTypeDto>? documentTypes) {
  return documentTypes
      ?.map(
        (documentType) => S2Choice(
          value: documentType,
          title: documentType.name ?? "",
        ),
      )
      .toList();
}

choiceEventReasons(List<EventReasonDto>? eventReasons) {
  return eventReasons
      ?.map(
        (eventReason) => S2Choice(
          value: eventReason,
          title: eventReason.name ?? "",
        ),
      )
      .toList();
}

choiceTypeEvents(List<TypeEventDto>? typeEvents) {
  return typeEvents
      ?.map(
        (typeEvent) => S2Choice(
          value: typeEvent,
          title: typeEvent.name ?? "",
        ),
      )
      .toList();
}