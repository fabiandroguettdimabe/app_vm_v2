import 'package:app_vm/constants/widgets/avatar.icon.title.widget.dart';
import 'package:app_vm/features/services/application/service.service.dart';
import 'package:app_vm/features/services/domain/service.dto.dart';
import 'package:app_vm/theme/color.config.dart';
import 'package:app_vm/utils/log.util.dart';
import 'package:app_vm/utils/map.util.dart';
import 'package:async_builder/async_builder.dart';
import 'package:async_button_builder/async_button_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:map_launcher/map_launcher.dart';

class ServiceToRelievedScreen extends StatefulWidget {
  const ServiceToRelievedScreen({super.key});

  @override
  State<ServiceToRelievedScreen> createState() => _ServiceConfirmScreenState();
}

class _ServiceConfirmScreenState extends State<ServiceToRelievedScreen> {
  @override
  Widget build(BuildContext context) {
    return AsyncBuilder(
      future: ServiceService.getServicesRelieved(),
      waiting: (context) => const Center(child: CircularProgressIndicator()),
      error: (context, error, stackTrace) => Center(
        child: Text('Error: $error'),
      ),
      builder: (context, data) {
        var services = data as List<ServiceRelievedDto>;
        return Scaffold(
            appBar: AppBar(
              title: const Text('Viajes asignados'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () => setState(() {}),
                ),
              ],
            ),
            body: services.isNotEmpty ? ListView.builder(
              itemCount: services.length,
              itemBuilder: (context, index) => buildServiceCard(services[index]),

            ) : const Center(
              child: Text('No hay servicios para relevar'),
            )
        );
      },
    );
  }

  Card buildServiceCard(ServiceRelievedDto service) {
    return Card(
      elevation: 0,
      child: Wrap(
        children: [
          ListTile(
            leading:
            AvatarIconTitleWidget(icon: FontAwesome.truck_moving_solid),
            title: Text("Servicio : N° ${service.id}" ?? "",
                style: TextStyle(
                    color: primaryColorLight, fontWeight: FontWeight.bold)),
            dense: true,
            subtitle: Text(service.description ?? ""),
          ),
          GFCard(
            padding: const EdgeInsets.all(0),
            elevation: 0,
            title: const GFListTile(
                avatar: Icon(Icons.info), title: Text("Detalle del servicio")),
            content: buildServiceDetails(service),
            buttonBar: GFButtonBar(
              children: [
                AsyncButtonBuilder(
                  child: const Text("Iniciar Viaje",
                      style: TextStyle(color: Colors.white)),
                  onPressed: () async {
                    var log = await createLog();
                    var dto = ServiceStartDto(startLog: log);
                    await ServiceService.startService(service.id!, dto);
                    setState(() {

                    });
                  },
                  builder: (context, child, callback, buttonState) {
                    return ElevatedButton.icon(
                      icon: const Icon(Mdi.truckFast, color: Colors.white),
                      onPressed: callback,
                      label: child,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: successColor,
                        minimumSize: const Size.fromHeight(50),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Wrap buildServiceDetails(ServiceRelievedDto service) {
    return Wrap(
      children: [
        buildServiceDetail(
            service.client?.name ?? "", FontAwesome.building, "Cliente: "),
        buildServiceDetail(
            service.originLocation?.name ?? "", Icons.location_on, "Origen : "),
        buildServiceDetail(service.destinyLocation?.name ?? "",
            Icons.location_on_outlined, "Destino : "),
        buildServiceDetail(service.collectionMethod!.name! ?? "",
            Mdi.accountCash, "¿Que traslada?: "),
        buildServiceDetail(
            service.journeyType!.name! ?? "", Mdi.trainCar, "Tipo de viaje : "),
        buildServiceDetail(
            service.relievedBy! ?? "", FontAwesome.car, "Tipo de viaje : "),
      ],
    );
  }

  Padding buildServiceDetail(String detail, IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: ListTile(
        leading: AvatarIconTitleWidget(icon: icon),
        dense: true,
        title: Text(title),
        subtitle: Text(detail),
      ),
    );
  }
}
