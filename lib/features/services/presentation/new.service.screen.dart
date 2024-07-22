import 'package:app_vm/constants/widgets/avatar.icon.title.widget.dart';
import 'package:app_vm/features/clients/domain/client.dto.dart';
import 'package:app_vm/features/locations/domain/location.dto.dart';
import 'package:app_vm/features/operations/application/operation.service.dart';
import 'package:app_vm/features/operations/domain/operation.dto.dart';
import 'package:app_vm/features/services/application/section.service.dart';
import 'package:app_vm/features/services/application/service.service.dart';
import 'package:app_vm/features/services/domain/collection.method.dto.dart';
import 'package:app_vm/features/services/domain/journey.type.dto.dart';
import 'package:app_vm/features/services/domain/service.dto.dart';
import 'package:app_vm/features/trucks/application/truck.service.dart';
import 'package:app_vm/features/trucks/domain/truck.dto.dart';
import 'package:app_vm/preferences/user.preferences.dart';
import 'package:app_vm/theme/color.config.dart';
import 'package:app_vm/utils/choice.util.dart';
import 'package:app_vm/utils/log.util.dart';
import 'package:async_button_builder/async_button_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_awesome_select_clone/flutter_awesome_select.dart';
import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NewServiceScreen extends StatefulWidget {
  const NewServiceScreen({super.key});

  @override
  State<NewServiceScreen> createState() => _NewServiceScreenState();
}

class _NewServiceScreenState extends State<NewServiceScreen> {
  TruckDto? truckSelected;
  OperationDto? operationSelected;
  ClientDto? clientSelected;
  List<ClientDto>? clientList = [];
  LocationListDto? originSelected;
  List<LocationListDto>? originList = [];
  LocationListDto? destinySelected;
  List<LocationListDto>? destinyList = [];
  CollectionMethodDto? collectionMethodSelected;
  List<CollectionMethodDto>? collectionMethodList = [];
  JourneyTypeDto? journeyTypeSelected;
  List<JourneyTypeDto>? journeyTypeList = [];
  int? sectionId;

  @override
  void initState() {
    loadSelection();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getData(originSelected?.id, destinySelected?.id,
          collectionMethodSelected?.id, journeyTypeSelected?.id);
    });
  }

  loadSelection() {
    // Load current truck
    var truckId = UserPreferences().getIntSync('truckId');
    var truckPatent = UserPreferences().getStringSync('truckPatent');
    var truckNumber = UserPreferences().getStringSync('truckNumber');
    var currentTruck =
        TruckDto(id: truckId, patent: truckPatent, truckNumber: truckNumber);
    // Load current operation
    var operationId = UserPreferences().getIntSync('operationId');
    var operationName = UserPreferences().getStringSync('operationName');
    var supervisorName = UserPreferences().getStringSync('supervisorName');
    var currentOperation = OperationDto(
        id: operationId, name: operationName, supervisorName: supervisorName);
    // Load current client
    var clientId = UserPreferences().getIntSync('clientId');
    var clientName = UserPreferences().getStringSync('clientName');
    var currentClient = ClientDto(id: clientId, name: clientName);
    setState(() {
      truckSelected = currentTruck;
      operationSelected = currentOperation;
      clientSelected = currentClient;
    });
  }

  getData(int? originId, int? destinyId, int? collectionMethodId,
      int? journeyTypeId) async {
    var operationId = await UserPreferences.getInt('operationId');
    var clientId = await UserPreferences.getInt('clientId');
    var data = await SectionService.getDataForNewService(
      operationId: operationId,
      clientId: clientId,
      originId: originId,
      destinyId: destinyId,
      collectionMethod: collectionMethodId,
      journeyTypeId: journeyTypeId,
    );
    setState(() {
      clientList = data?.clientIds;
      originSelected = data?.originId;
      originList = data?.originIds;
      destinySelected = data?.destinyId;
      destinyList = data?.destinyIds;
      if (data?.collectionMethodIds != null) {
        collectionMethodList = data?.collectionMethodIds;
        if (collectionMethodList!.length == 1) {
          collectionMethodSelected = collectionMethodList!.first;
        }
      }
      collectionMethodList = data?.collectionMethodIds;
      if (data?.journeyTypeIds != null) {
        journeyTypeList = data?.journeyTypeIds;
        if (data?.journeyTypeIds!.length == 1) {
          journeyTypeSelected = journeyTypeList!.first;
        }
      }
      sectionId = data?.sectionId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Nuevo servicio'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(Adaptive.px(10)),
                child: ListTile(
                  leading: AvatarIconTitleWidget(
                      icon: Icons.local_shipping, color: Colors.white),
                  title:
                      const Text("Camion Actual", textAlign: TextAlign.start),
                  subtitle: truckSelected != null
                      ? Text(
                          "${truckSelected!.patent!} - N° ${truckSelected!.truckNumber!}")
                      : null,
                  dense: true,
                  trailing: AvatarIconTitleWidget(icon: Icons.arrow_forward),
                  onTap: () => Get.bottomSheet(buildBottomSheetTruck(),
                      backgroundColor: Get.theme.dialogBackgroundColor),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              smartSelectOperation(),
              const SizedBox(
                height: 20,
              ),
              selectClient(),
              const SizedBox(
                height: 20,
              ),
              selectOrigin(),
              const SizedBox(
                height: 20,
              ),
              selectDestiny(),
              const SizedBox(
                height: 20,
              ),
              Visibility(
                  visible: collectionMethodList!.isNotEmpty,
                  child: selectCollectionMethod()),
              const SizedBox(
                height: 20,
              ),
              Visibility(
                  visible: journeyTypeList!.isNotEmpty,
                  child: selectJourneyType()),
              const SizedBox(
                height: 20,
              ),
              AsyncButtonBuilder(
                child: ListTile(
                  leading: AvatarIconTitleWidget(icon: Mdi.truckCheck),
                  title:
                      const Text("Iniciar Viaje", textAlign: TextAlign.center),
                ),
                onPressed: () async {
                  if (sectionId == null) {
                    Get.snackbar("Error", "No se puede iniciar el viaje");
                  } else {
                    var model = CreateServiceDto(
                      sectionId: sectionId,
                      truckId: truckSelected?.id,
                      originId: originSelected?.id,
                      destinyId: destinySelected?.id,
                      collectionMethodId: collectionMethodSelected?.id,
                      journeyTypeId: journeyTypeSelected?.id,
                      clientId: clientSelected?.id,
                      createLog: await createLog(),
                    );
                    var result = await ServiceService.createService(model);
                  }
                },
                builder: (context, child, callback, buttonState) {
                  return ElevatedButton(
                    onPressed: callback,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: successColor,
                      minimumSize: const Size.fromHeight(50),
                    ),
                    child: child,
                  );
                },
              )
            ],
          ),
        ));
  }

  Widget buildBottomSheetTruck() {
    return Wrap(
      children: [
        ListTile(
          leading: AvatarIconTitleWidget(icon: Icons.local_shipping),
          title:
              const Text('Seleccione un camion', textAlign: TextAlign.center),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(10),
          child: buildSmartSelectTruck(),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: AsyncButtonBuilder(
                child: const Text("Escanear QR",
                    style: TextStyle(color: Colors.white)),
                onPressed: () async {},
                builder: (context, child, callback, buttonState) {
                  return ElevatedButton.icon(
                    onPressed: callback,
                    icon: const Icon(Icons.qr_code, color: Colors.white),
                    label: child,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColorDark,
                    ),
                  );
                },
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget buildSmartSelectTruck() {
    return FutureBuilder<List<TruckDto>?>(
      future: TruckService.getTrucks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return SmartSelect.single(
            selectedValue: truckSelected,
            choiceItems: choiceTrucks(snapshot.data),
            modalHeaderStyle: S2ModalHeaderStyle(
              centerTitle: true,
              textStyle: Get.theme.textTheme.titleSmall,
              actionsIconTheme: Get.theme.iconTheme,
              iconTheme: Get.theme.iconTheme,
            ),
            tileBuilder: (context, state) {
              return ListTile(
                leading: AvatarIconTitleWidget(icon: Icons.local_shipping),
                title: Text(truckSelected?.patent ?? "Seleccione un camion",
                    textAlign: TextAlign.center),
                subtitle: Text(truckSelected?.truckNumber ?? "",
                    textAlign: TextAlign.center),
                dense: true,
                onTap: state.showModal,
                trailing: AvatarIconTitleWidget(icon: Icons.arrow_forward),
              );
            },
            title: "Seleccione un camion",
            modalFilter: true,
            modalFilterAuto: true,
            modalFilterHint: "Buscar",
            modalConfig: const S2ModalConfig(
              type: S2ModalType.bottomSheet,
            ),
            onChange: (value) {
              setState(() {
                truckSelected = value.value;
              });
            },
          );
        }
      },
    );
  }

  Widget smartSelectOperation() {
    return FutureBuilder<List<OperationDto>?>(
      future: OperationService.getOperations(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return SmartSelect.single(
            choiceItems: choiceOperations(snapshot.data!),
            modalHeaderStyle: S2ModalHeaderStyle(
              centerTitle: true,
              textStyle: Get.theme.textTheme.titleSmall,
              actionsIconTheme: Get.theme.iconTheme,
              iconTheme: Get.theme.iconTheme,
            ),
            tileBuilder: (context, state) {
              return ListTile(
                leading: AvatarIconTitleWidget(icon: Mdi.windowShutterCog),
                title: Text(
                    operationSelected?.name ?? "Seleccione una operacion",
                    textAlign: TextAlign.start),
                subtitle: Text(operationSelected?.supervisorName ?? "",
                    textAlign: TextAlign.start),
                dense: true,
                onTap: state.showModal,
                trailing: AvatarIconTitleWidget(icon: Icons.arrow_forward),
              );
            },
            title: "Seleccione una operacion",
            modalFilter: true,
            modalFilterAuto: true,
            modalFilterHint: "Buscar",
            modalConfig: const S2ModalConfig(
              type: S2ModalType.bottomSheet,
            ),
            selectedValue: operationSelected,
            onChange: (value) async {
              await UserPreferences.set('operationId', value.value?.id);
              await UserPreferences.set('operationName', value.value?.name);
              await UserPreferences.set(
                  'supervisorName', value.value?.supervisorName);
              await getData(originSelected?.id, destinySelected?.id,
                  collectionMethodSelected?.id, journeyTypeSelected?.id);
              setState(() {
                operationSelected = value.value;
              });
            },
          );
        }
      },
    );
  }

  Widget selectClient() {
    return SmartSelect.single(
      selectedValue: clientSelected,
      choiceItems: choiceClients(clientList),
      modalHeaderStyle: S2ModalHeaderStyle(
        centerTitle: true,
        textStyle: Get.theme.textTheme.titleSmall,
        actionsIconTheme: Get.theme.iconTheme,
        iconTheme: Get.theme.iconTheme,
      ),
      tileBuilder: (context, state) {
        return ListTile(
          leading: AvatarIconTitleWidget(icon: Icons.apartment),
          title: clientSelected != null
              ? Text("Cliente : ${clientSelected?.name}")
              : const Text("Cliente", textAlign: TextAlign.start),
          dense: true,
          onTap: state.showModal,
          trailing: AvatarIconTitleWidget(icon: Icons.arrow_forward),
        );
      },
      title: "Seleccione el cliente",
      modalFilter: true,
      modalFilterAuto: true,
      modalFilterHint: "Buscar",
      modalConfig: const S2ModalConfig(
        type: S2ModalType.bottomSheet,
      ),
      onChange: (value) async {
        await UserPreferences.set('clientId', value.value?.id);
        await UserPreferences.set('clientName', value.value?.name);
        await getData(originSelected?.id, destinySelected?.id,
            collectionMethodSelected?.id, journeyTypeSelected?.id);
        setState(() {
          clientSelected = value.value;
        });
      },
    );
  }

  Widget selectOrigin() {
    return SmartSelect.single(
      selectedValue: originSelected,
      choiceItems: choiceLocations(originList),
      modalHeaderStyle: S2ModalHeaderStyle(
        centerTitle: true,
        textStyle: Get.theme.textTheme.titleSmall,
        actionsIconTheme: Get.theme.iconTheme,
        iconTheme: Get.theme.iconTheme,
      ),
      tileBuilder: (context, state) {
        return ListTile(
          leading: AvatarIconTitleWidget(icon: Icons.location_on),
          title: originSelected != null
              ? Text("Origen : ${originSelected?.name}")
              : const Text("Origen", textAlign: TextAlign.start),
          subtitle: originSelected != null
              ? Text("Direccción : ${originSelected?.address}")
              : const Text("Seleccione el origen del viaje",
                  textAlign: TextAlign.start),
          dense: true,
          onTap: state.showModal,
          trailing: AvatarIconTitleWidget(icon: Icons.arrow_forward),
        );
      },
      title: "Seleccione el origen del viaje",
      modalFilter: true,
      modalFilterAuto: true,
      modalFilterHint: "Buscar",
      modalConfig: const S2ModalConfig(
        type: S2ModalType.bottomSheet,
      ),
      onChange: (value) async {
        await getData(value.value?.id, null, null, null);
        setState(() {
          originSelected = value.value;
          if (destinySelected != null) destinySelected = null;
          if (collectionMethodSelected != null) collectionMethodSelected = null;
          if (journeyTypeSelected != null) journeyTypeSelected = null;
        });
      },
    );
  }

  Widget selectDestiny() {
    return SmartSelect.single(
      selectedValue: destinySelected,
      choiceItems: choiceLocations(destinyList),
      modalHeaderStyle: S2ModalHeaderStyle(
        centerTitle: true,
        textStyle: Get.theme.textTheme.titleSmall,
        actionsIconTheme: Get.theme.iconTheme,
        iconTheme: Get.theme.iconTheme,
      ),
      tileBuilder: (context, state) {
        return ListTile(
          leading: AvatarIconTitleWidget(icon: Icons.location_on_outlined),
          title: destinySelected != null
              ? Text("Destino : ${destinySelected?.name}")
              : const Text("Destino", textAlign: TextAlign.start),
          subtitle: destinySelected != null
              ? Text("Direccción : ${destinySelected?.address}")
              : const Text("Seleccione el destino del viaje",
                  textAlign: TextAlign.start),
          dense: true,
          onTap: state.showModal,
          trailing: AvatarIconTitleWidget(icon: Icons.arrow_forward),
        );
      },
      title: "Seleccione el destino del viaje",
      modalFilter: true,
      modalFilterAuto: true,
      modalFilterHint: "Buscar",
      modalConfig: const S2ModalConfig(
        type: S2ModalType.bottomSheet,
      ),
      onChange: (value) async {
        await getData(originSelected?.id, value.value?.id,
            collectionMethodSelected?.id, journeyTypeSelected?.id);
        setState(() {
          destinySelected = value.value;
        });
      },
    );
  }

  Widget selectCollectionMethod() {
    return SmartSelect.single(
      selectedValue: collectionMethodSelected,
      choiceItems: choiceCollectionMethods(collectionMethodList),
      modalHeaderStyle: S2ModalHeaderStyle(
        centerTitle: true,
        textStyle: Get.theme.textTheme.titleSmall,
        actionsIconTheme: Get.theme.iconTheme,
        iconTheme: Get.theme.iconTheme,
      ),
      tileBuilder: (context, state) {
        return ListTile(
          leading: AvatarIconTitleWidget(icon: Mdi.accountCash),
          title: collectionMethodSelected != null
              ? Text("Traslada : ${collectionMethodSelected?.name}")
              : const Text("¿Que traslada?", textAlign: TextAlign.start),
          dense: true,
          onTap: state.showModal,
          trailing: AvatarIconTitleWidget(icon: Icons.arrow_forward),
        );
      },
      title: "Seleccione que traslada en el viaje",
      modalFilter: true,
      modalFilterAuto: true,
      modalFilterHint: "Buscar",
      modalConfig: const S2ModalConfig(
        type: S2ModalType.bottomSheet,
      ),
      onChange: (value) async {
        await getData(originSelected?.id, destinySelected?.id, value.value?.id,
            journeyTypeSelected?.id);
        setState(() {
          collectionMethodSelected = value.value;
        });
      },
    );
  }

  Widget selectJourneyType() {
    return SmartSelect.single(
      selectedValue: journeyTypeSelected,
      choiceItems: choiceJourneyType(journeyTypeList),
      modalHeaderStyle: S2ModalHeaderStyle(
        centerTitle: true,
        textStyle: Get.theme.textTheme.titleSmall,
        actionsIconTheme: Get.theme.iconTheme,
        iconTheme: Get.theme.iconTheme,
      ),
      tileBuilder: (context, state) {
        return ListTile(
          leading: AvatarIconTitleWidget(icon: Mdi.trainCar),
          title: journeyTypeSelected != null
              ? Text("Tipo de viaje : ${journeyTypeSelected?.name}")
              : const Text("Tipo de viaje", textAlign: TextAlign.start),
          dense: true,
          onTap: state.showModal,
          trailing: AvatarIconTitleWidget(icon: Icons.arrow_forward),
        );
      },
      title: "Seleccione el tipo de viaje",
      modalFilter: true,
      modalFilterAuto: true,
      modalFilterHint: "Buscar",
      modalConfig: const S2ModalConfig(
        type: S2ModalType.bottomSheet,
      ),
      onChange: (value) async {
        await getData(originSelected?.id, destinySelected?.id, value.value?.id,
            value.value?.id);
        setState(() {
          journeyTypeSelected = value.value;
        });
      },
    );
  }
}
