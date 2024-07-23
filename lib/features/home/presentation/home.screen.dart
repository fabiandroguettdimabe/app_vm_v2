import 'package:app_vm/constants/widgets/avatar.icon.title.widget.dart';
import 'package:app_vm/features/clients/application/client.service.dart';
import 'package:app_vm/features/clients/domain/client.dto.dart';
import 'package:app_vm/features/operations/application/operation.service.dart';
import 'package:app_vm/features/operations/domain/operation.dto.dart';
import 'package:app_vm/features/services/application/service.service.dart';
import 'package:app_vm/features/services/domain/service.dto.dart';
import 'package:app_vm/features/trucks/application/truck.service.dart';
import 'package:app_vm/features/trucks/domain/truck.dto.dart';
import 'package:app_vm/preferences/user.preferences.dart';
import 'package:app_vm/theme/color.config.dart';
import 'package:app_vm/utils/choice.util.dart';
import 'package:async_builder/async_builder.dart';
import 'package:async_button_builder/async_button_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_select_clone/flutter_awesome_select.dart';
import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TruckDto? truckSelected;
  OperationDto? operationSelected;
  ClientDto? clientSelected;
  int? qtyServiceInProcess;

  @override
  void initState() {
    loadSelection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          AsyncButtonBuilder(
            child: const Icon(Icons.logout),
            onPressed: () async {
              UserPreferences.clear();
              Get.offNamed('/login');
            },
            builder: (context, child, callback, buttonState) {
              return IconButton(
                icon: child,
                onPressed: callback,
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: ListTile(
              leading: AvatarIconTitleWidget(
                  icon: FontAwesome.truck_moving_solid, color: Colors.white),
              title: const Text('Camión Actual'),
              subtitle: truckSelected == null
                  ? const Text('Seleccione un camión')
                  : Text(
                      "${truckSelected!.patent} - N° ${truckSelected!.truckNumber}"),
              dense: true,
              trailing: AvatarIconTitleWidget(
                icon: FontAwesome.arrow_right_long_solid,
              ),
              onTap: () => Get.bottomSheet(
                buildBottomSheetTruck(),
                backgroundColor: Get.theme.dialogBackgroundColor,
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(15), child: smartSelectOperation()),
          Padding(
              padding: const EdgeInsets.all(15), child: smartSelectClients()),
          Padding(
            padding: const EdgeInsets.all(15),
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed('/new-service');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: successColor,
                minimumSize: const Size.fromHeight(50),
              ),
              child: const ListTile(
                leading: Icon(Mdi.truckPlus, color: Colors.white),
                title: Text(
                  "Nuevo Viaje",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          AsyncBuilder(
              future: ServiceService.getQtyServiceInProcess(),
              waiting: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
              builder: (context, value) {
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: AsyncButtonBuilder(
                    child: ListTile(
                      leading: const Icon(Mdi.truckFast, color: Colors.white),
                      title: const Text("Viajes en proceso",
                          style: TextStyle(color: Colors.white)),
                      trailing: Text(
                        value?.toString() ?? "",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    onPressed: () async {
                      var serviceInProcess =
                          await ServiceService.getServicesInProcess();
                      Get.bottomSheet(
                          buildBottomSheetServiceInProcess(serviceInProcess),
                          backgroundColor: Get.theme.dialogBackgroundColor);
                    },
                    builder: (context, child, callback, buttonState) {
                      return ElevatedButton(
                        onPressed: callback,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColorDark,
                          minimumSize: const Size.fromHeight(50),
                        ),
                        child: child,
                      );
                    },
                  ),
                );
              }),
          Padding(
            padding: const EdgeInsets.all(15),
            child: ElevatedButton(
                onPressed: () {
                  Get.toNamed('/services-confirmed');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColorDark,
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const ListTile(
                  leading: Icon(Mdi.listBox, color: Colors.white),
                  title: Text(
                    "Viajes asignados",
                    style: TextStyle(color: Colors.white),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColorDark,
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const ListTile(
                  leading: Icon(FontAwesome.handshake, color: Colors.white),
                  title: Text(
                    "Viajes para relevar",
                    style: TextStyle(color: Colors.white),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColorDark,
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const ListTile(
                  leading:
                      Icon(FontAwesome.calendar_check, color: Colors.white),
                  title: Text(
                    "Viajes finalizados",
                    style: TextStyle(color: Colors.white),
                  ),
                )),
          ),
        ],
      ),
    );
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
        ),
        const Divider(),
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton.icon(
                onPressed: () {},
                label: const Text("Cancelar",
                    style: TextStyle(color: Colors.white)),
                icon: const Icon(Icons.cancel, color: Colors.white),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: AsyncButtonBuilder(
                child: const Text("Guardar",
                    style: TextStyle(color: Colors.white)),
                onPressed: () async {
                  await UserPreferences.set('truckId', truckSelected?.id);
                  await UserPreferences.set(
                      'truckPatent', truckSelected?.patent);
                  await UserPreferences.set(
                      'truckNumber', truckSelected?.truckNumber);
                  Get.back();
                },
                builder: (context, child, callback, buttonState) {
                  return ElevatedButton.icon(
                    onPressed: callback,
                    icon: const Icon(Icons.save, color: Colors.white),
                    label: child,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: successColor,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildBottomSheetServiceInProcess(
      List<ServiceInProcessDto>? serviceInProcess) {
    return Wrap(
      children: [
        ListTile(
          leading: AvatarIconTitleWidget(icon: FontAwesome.truck_moving_solid),
          title: const Text('Viajes en proceso'),
        ),
        ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            shrinkWrap: true,
            controller: ScrollController(),
            itemCount: serviceInProcess!.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading:
                    AvatarIconTitleWidget(icon: FontAwesome.truck_moving_solid),
                title: Text(
                  "Servicio : N° ${serviceInProcess![index].id}" ?? "",
                  style: TextStyle(
                    color: primaryColorLight,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(serviceInProcess![index].description ?? ""),
                trailing: const Icon(FontAwesome.arrow_right_long_solid),
                onTap: () {
                  Get.toNamed('/service', arguments: {
                    'id': serviceInProcess![index].id,
                  });
                },
              );
            }),
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
                trailing: AvatarIconTitleWidget(
                    icon: FontAwesome.arrow_right_long_solid),
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

              setState(() {
                operationSelected = value.value;
              });
            },
          );
        }
      },
    );
  }

  Widget smartSelectClients() {
    return FutureBuilder<List<ClientDto>?>(
      future: ClientService.getClientsByOperations(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return SmartSelect.single(
            choiceItems: choiceClients(snapshot.data!),
            modalHeaderStyle: S2ModalHeaderStyle(
              centerTitle: true,
              textStyle: Get.theme.textTheme.titleSmall,
              actionsIconTheme: Get.theme.iconTheme,
              iconTheme: Get.theme.iconTheme,
            ),
            tileBuilder: (context, state) {
              return ListTile(
                leading: AvatarIconTitleWidget(icon: Icons.apartment),
                title: Text(clientSelected?.name ?? "Seleccione un cliente",
                    textAlign: TextAlign.start),
                dense: true,
                onTap: state.showModal,
                trailing: AvatarIconTitleWidget(
                    icon: FontAwesome.arrow_right_long_solid),
              );
            },
            title: "Seleccione una cliente",
            modalFilter: true,
            modalFilterAuto: true,
            modalFilterHint: "Buscar",
            modalConfig: const S2ModalConfig(
              type: S2ModalType.bottomSheet,
            ),
            selectedValue: clientSelected,
            onChange: (value) async {
              await UserPreferences.set('clientId', value.value?.id);
              await UserPreferences.set('clientName', value.value?.name);
              setState(() {
                clientSelected = value.value;
              });
            },
          );
        }
      },
    );
  }
}
